package com.tokio.cotizador.ManualPortlet.portlet;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;

import org.apache.commons.io.IOUtils;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;

import com.google.gson.Gson;
import com.liferay.portal.kernel.model.User;
import com.liferay.portal.kernel.portlet.bridges.mvc.BaseMVCResourceCommand;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCResourceCommand;
import com.liferay.portal.kernel.upload.FileItem;
import com.liferay.portal.kernel.upload.UploadPortletRequest;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.PortalUtil;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.kernel.util.WebKeys;
import com.tokio.cotizador.CotizadorService;
import com.tokio.cotizador.Bean.DocumentoResponse;
import com.tokio.cotizador.ManualPortlet.constants.CotizadorManualPortletKeys;
import com.tokio.cotizador.util.Codifica;


@Component(
	    immediate = true,
	    property = {
		        "javax.portlet.name="+ CotizadorManualPortletKeys.PORTLET_NAME,
		        "mvc.command.name=/getUserDocuments"
	    },
	    service = MVCResourceCommand.class
	)

public class CotizadorManualResourceCommand extends BaseMVCResourceCommand{
	
	@Reference
	CotizadorService _CotizadorService; 

	
	@Override
	protected void doServeResource(ResourceRequest resourceRequest, ResourceResponse resourceResponse)
			throws Exception {
		List<String> listaArchivo = new ArrayList<String>();
		String directorio = "/temp/";
		try{
		
			int idCotizacion = ParamUtil.getInteger(resourceRequest, "idCotizacion");

			//			String []listaTipoArchivo= ParamUtil.getStringValues(resourceRequest, "tipoArchivos[]");
			
			String []listaNombreArchivos= ParamUtil.getStringValues(resourceRequest, "nombreArchivos[]");
			
			UploadPortletRequest urequest = PortalUtil.getUploadPortletRequest(resourceRequest);
			Map<String, FileItem[]> files= urequest.getMultipartParameterMap();
	
			
			for (Entry<String, FileItem[]> file2 : files.entrySet()) {
				FileItem item[] =file2.getValue();
				for( int i =0; i< item.length; i++ ){
					File f = item[i].getStoreLocation();
					System.out.println(f);
					byte[] buffer = new byte[1024];
					ZipInputStream zis = new ZipInputStream(new FileInputStream(f));
					ZipEntry zipEntry = zis.getNextEntry();
	
					while(zipEntry != null){
						String fileName = zipEntry.getName();
						listaArchivo.add(fileName);
						System.out.println(directorio + fileName);
						File newFile = new File( directorio + fileName);
						FileOutputStream fos = new FileOutputStream(newFile);
						int len;
						while ((len = zis.read(buffer)) > 0) {
							fos.write(buffer, 0, len);
						}
						fos.close();
						zipEntry = zis.getNextEntry();
					}
					zis.closeEntry();
					zis.close();
					
					
					
				}
			}
			
			
			User user = (User) resourceRequest.getAttribute(WebKeys.USER);
			String nombre = "";
			File file = null;
			BufferedInputStream in = null;
			FileInputStream fis = null;
			StringBuilder builder = new StringBuilder();
			String tipo= "COTIZACIONES";
			String usuario = user.getScreenName();
			String pantalla = "Cotizador Manual";
			String tipoTransaccion = "I";
			int idCarpeta = 0;
			int idDocumento = 0;
			int idCatalogoDetalle = 0;
//			String tipoArchivo="";
			System.out.println("tamaño:" + listaNombreArchivos.length);
			for( int j=0; j<listaNombreArchivos.length; j++ ){
//				System.out.println("archivo" + listaTipoArchivo[j]);
//				tipoArchivo = listaTipoArchivo[j];
//				idCatalogoDetalle = Integer.parseInt(tipoArchivo);
				nombre = directorio + listaNombreArchivos[j] ;
				System.out.println(nombre);
				file = new File( nombre );
				fis = new FileInputStream(file);
				in = new BufferedInputStream( fis);
				if( j!=0 ){
					builder.append(",");
				}
				builder.append("{");
				builder.append("\"idCarpeta\":" + idCarpeta + ",");
				builder.append("\"idDocumento\":" + idDocumento+ ",");
				builder.append("\"idCatalogoDetalle\":" + idCatalogoDetalle+ ",");
				builder.append("\"documento\":\"" + Codifica.encode( IOUtils.toByteArray(in) )+ "\",");
				builder.append("\"nombre\":\"" + getFileName(file)  + "\",");
				builder.append("\"extension\":\"" + getFileExtension(file) +"\"" );
				builder.append("}");

				fis.close();
				in.close();
			}
			
			DocumentoResponse docResp = null; 
			docResp = _CotizadorService.wsDocumentos(0, tipoTransaccion, builder.toString(), 1, tipo, idCotizacion, "", usuario, pantalla);
			
			//pasar a string json  
			Gson gson = new Gson();
			String stringJson = gson.toJson(docResp);
			resourceResponse.getWriter().write(stringJson);
		
		}catch(Exception e){
			e.printStackTrace();
			resourceResponse.getWriter().write("{\"code\":2,\"totalRow\":0,\"lista\":[],\"msg\":\"Error: "+ e.getMessage().replaceAll("\\", "%20")+"\"}");
		} finally {
			System.out.println("entro a finally");
			if( Validator.isNotNull( listaArchivo) && listaArchivo.size()!=0 ){
				File fileAux;
				for( int j=0; j<listaArchivo.size(); j++){
					System.out.println(directorio + listaArchivo.get(j));
					fileAux = new File( directorio + listaArchivo.get(j) );
					fileAux.delete();
				}
			}
			
		}

		
	}
	 	
	private static String getFileExtension(File file) {
        String fileName = file.getName();
        if(fileName.lastIndexOf(".") != -1 && fileName.lastIndexOf(".") != 0)
        return fileName.substring(fileName.lastIndexOf(".")+1);
        else return "";
    }
	
	private static String getFileName(File file) {
        String fileName = file.getName();
        if(fileName.lastIndexOf(".") != -1 && fileName.lastIndexOf(".") != 0)
        	return fileName.substring(0,fileName.lastIndexOf("."));
        else return "";
    }


}
