package com.tokio.cotizador.ManualPortlet.portlet;

import java.io.PrintWriter;
import java.util.Enumeration;

import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;

import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;

import com.google.gson.Gson;
import com.liferay.portal.kernel.model.User;
import com.liferay.portal.kernel.portlet.bridges.mvc.BaseMVCResourceCommand;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCResourceCommand;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.WebKeys;
import com.tokio.cotizador.CotizadorService;
import com.tokio.cotizador.Bean.SimpleResponse;
import com.tokio.cotizador.ManualPortlet.constants.CotizadorManualPortletKeys;


@Component(
	    immediate = true,
	    property = {
		        "javax.portlet.name="+ CotizadorManualPortletKeys.PORTLET_NAME,
		        "mvc.command.name=/submitForm"
	    },
	    service = MVCResourceCommand.class
	)

public class SaveFormResourceCommand extends BaseMVCResourceCommand{
	
	@Reference
	CotizadorService _CotizadorService; 

	
	@Override
	protected void doServeResource(ResourceRequest resourceRequest, ResourceResponse resourceResponse)
			throws Exception {
		
		User user = (User) resourceRequest.getAttribute(WebKeys.USER);
		String usuario = user.getScreenName();
		String pantalla = "CotizadorManual";
/*		
		Enumeration<String> params = resourceRequest.getParameterNames();
		String aux;
		while( params.hasMoreElements() ){
			aux = params.nextElement();
			System.out.println( aux + ":" +  resourceRequest.getParameter(aux) );
			
		}
*/		
		int tipoCliente = ParamUtil.getInteger(resourceRequest, "group20");
		String rfcExistente = ParamUtil.getString(resourceRequest, "rfcContraCteExt");
		String codigoCliente = ParamUtil.getString(resourceRequest, "codCteExtOc");
		int tipoMovimiento = ParamUtil.getInteger(resourceRequest, "tipoMovimiento");
		String polizaAnterior = ParamUtil.getString(resourceRequest, "poliza");
		String fechaInicio = ParamUtil.getString(resourceRequest, "dateDesde");
		String fechaFin = ParamUtil.getString(resourceRequest, "dateHasta");
		int agente = ParamUtil.getInteger(resourceRequest, "agente");
		int moneda = ParamUtil.getInteger(resourceRequest, "moneda");
		int formaPago = ParamUtil.getInteger(resourceRequest, "formaPago");
		int producto = ParamUtil.getInteger(resourceRequest, "producto");
		String mensaje = ParamUtil.getString(resourceRequest, "textoMensaje");

		int tipoPersona = ParamUtil.getInteger(resourceRequest, "persona");//0 = fisica & 1=moral
		String rfcNuevo = ParamUtil.getString(resourceRequest, "rfcNvFisic");
		String nombreNuevo = ParamUtil.getString(resourceRequest, "nomNvFisic");
		String appellidoM = ParamUtil.getString(resourceRequest, "apMatNvFisic");
		String appellidoP = ParamUtil.getString(resourceRequest, "apPatNvFisic");
		

		String rfcMoral = ParamUtil.getString(resourceRequest, "rfcNvoMoral");
		String nombreMoral = ParamUtil.getString(resourceRequest, "nomNvMoral");
		int denominacionMoral = ParamUtil.getInteger(resourceRequest, "estNvMor");
		
		int idPersona = ParamUtil.getInteger(resourceRequest, "idPersonaHidden");
		int tipOper = ParamUtil.getInteger(resourceRequest, "tipOperHidden");
		String nombre = ParamUtil.getString(resourceRequest, "nombreHidden");
		String appPaterno = ParamUtil.getString(resourceRequest, "appPaternoHidden");
		String appMaterno = ParamUtil.getString(resourceRequest, "appMaternoHidden");
		int idDenominacion = ParamUtil.getInteger(resourceRequest, "idDenominacionHidden");
		
		
		
		System.out.println("recibo formulario:");
		SimpleResponse simpleResponse = null;
		String jsonString = "{\"code\":1,\"msg\":\"Error al procesar solicitud\",\"folio\":\" \",\"idCotizacion\":0}";
		try{
			if(  tipoCliente ==0 ){
				simpleResponse = _CotizadorService.solCotizacion(idPersona, tipOper, rfcExistente, nombre, appPaterno, appMaterno,
						idDenominacion, codigoCliente, tipoMovimiento, polizaAnterior,producto, moneda, fechaInicio,
						fechaFin,agente, formaPago, mensaje, usuario, pantalla);
			}else{
				if( tipoPersona == 1){
					simpleResponse = _CotizadorService.solCotizacion(0, tipoPersona, rfcNuevo, nombreNuevo, appellidoP, appellidoM,
							denominacionMoral, "", tipoMovimiento, polizaAnterior,producto, moneda, fechaInicio,
							fechaFin, agente, formaPago, mensaje, usuario, pantalla);
				}else{
					simpleResponse = _CotizadorService.solCotizacion(0, tipoPersona, rfcMoral, nombreMoral, appellidoP, appellidoM,
							denominacionMoral, "", tipoMovimiento, polizaAnterior,producto, moneda, fechaInicio,
							fechaFin, agente, formaPago, mensaje, usuario, pantalla);
				}
			}
			Gson gson = new Gson();
			System.out.println("service" + simpleResponse );
			jsonString = gson.toJson( simpleResponse );

		}catch(Exception e){
			e.printStackTrace();
		}
		
		PrintWriter writer = resourceResponse.getWriter();
		writer.write(jsonString);


		
		
	}
	 	
	

}
