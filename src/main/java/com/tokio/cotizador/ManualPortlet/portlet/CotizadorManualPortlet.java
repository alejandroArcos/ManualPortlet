package com.tokio.cotizador.ManualPortlet.portlet;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.portlet.Portlet;
import javax.portlet.PortletException;

import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;
import javax.servlet.http.HttpServletRequest;

import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;

import com.liferay.portal.kernel.model.User;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCPortlet;
import com.liferay.portal.kernel.servlet.SessionErrors;
import com.liferay.portal.kernel.util.PortalUtil;
import com.liferay.portal.kernel.util.WebKeys;
import com.tokio.cotizador.CotizadorService;
import com.tokio.cotizador.Bean.Persona;
import com.tokio.cotizador.Bean.Registro;
import com.tokio.cotizador.constants.CotizadorServiceKey;

@Component(
	immediate = true,
	property = {
		"com.liferay.portlet.display-category=category.sample",
		"com.liferay.portlet.instanceable=true",
		"javax.portlet.display-name=ManualPortlet Portlet",
		"javax.portlet.init-param.template-path=/",
		"javax.portlet.init-param.view-template=/view.jsp",
		"javax.portlet.resource-bundle=content.Language",
		"javax.portlet.security-role-ref=power-user,user",
		"com.liferay.portlet.requires-namespaced-parameters=false"
	},
	service = Portlet.class
)
public class CotizadorManualPortlet extends MVCPortlet {
	
	DateFormat dateFormat = null;
	Calendar cal = null;
	Date today = null;
	Date nextYear = null;
	
	@Reference
	CotizadorService _CotizadorService;
	

	@SuppressWarnings("unchecked")
	@Override
	public void doView(RenderRequest renderRequest, RenderResponse renderResponse)
					throws IOException, PortletException {
		
		int rowNum = 0;
		String transaccion = "B";
		int active = 1;
		User user = (User) renderRequest.getAttribute(WebKeys.USER);
		String usuario = user.getScreenName();
		String pantalla = "Cotizaciones";
//		int idUsuario = 8;
		
		try {
			List<Registro> listaTipoMov = _CotizadorService.getCatalogo(rowNum,transaccion, CotizadorServiceKey.TIPO_MOVIMIENTO,active,usuario,pantalla);
			List<Registro> listaMoneda= _CotizadorService.getCatalogo(rowNum,transaccion,CotizadorServiceKey.LISTA_MONEDA,active,usuario,pantalla);
			List<Registro> listaPago= _CotizadorService.getCatalogo(rowNum,transaccion,CotizadorServiceKey.FORMA_PAGO,active,usuario,pantalla);
			List<Registro> listaProducto= _CotizadorService.getCatalogo(rowNum,transaccion,CotizadorServiceKey.LISTA_PRODUCTO,active,usuario,pantalla);
//			List<Registro> listaTipoArchivo= _CotizadorService.getCatalogo(rowNum,transaccion,CotizadorServiceKey.TIPO_ARCHIVO,active,usuario,pantalla);
			List<Registro> listaDenominacion= _CotizadorService.getCatalogo(rowNum,transaccion,CotizadorServiceKey.DENOMINACION,active,usuario,pantalla);
			
			HttpServletRequest originalRequest = PortalUtil
					.getOriginalServletRequest(PortalUtil.getHttpServletRequest(renderRequest));
			
			int idPerfilUser = (int) originalRequest.getSession().getAttribute("idPerfil");

			//Integer idUsuario = (Integer)originalRequest.getSession().getAttribute("idUsuario");
			List<Persona> listaAgente = (List<Persona>) originalRequest.getSession().getAttribute("listaAgentes");
			
//			List<Persona> listaAgente = _CotizadorService.getListaAgenteUsuario(idUsuario, usuario, pantalla);
			String fechaSeleccionada = null;
			vSeteaFechas(fechaSeleccionada);
			String fechaHoy = dateFormat.format(today);
			String fechaMasAnio = dateFormat.format(nextYear);
			
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

			Date fechaHoyAux = new Date();
			if (idPerfilUser == 1){
				/*fechaHoyAux = sumarDiasAFecha(fechaHoyAux, -30);*/				
				fechaHoyAux = sumarDiasAFecha(fechaHoyAux, 0);				
			}
			String hoyServidor =dateFormat.format(fechaHoyAux);
			
			System.out.println("hoyServidor : " + hoyServidor);
			
			renderRequest.setAttribute("hoyServidor", hoyServidor);
			renderRequest.setAttribute("fechaHoy", fechaHoy);
			renderRequest.setAttribute("nextAnio", fechaMasAnio);
			renderRequest.setAttribute("listaTipoMov", listaTipoMov);
			renderRequest.setAttribute("listaAgente", listaAgente);
			renderRequest.setAttribute("listaMoneda", listaMoneda);
			renderRequest.setAttribute("listaPago", listaPago);
			renderRequest.setAttribute("listaProducto", listaProducto);
//			renderRequest.setAttribute("listaTipoArchivo", listaTipoArchivo);
			renderRequest.setAttribute("listaDenominacion", listaDenominacion);
			renderRequest.setAttribute("usuario", usuario);
						
		} catch ( Exception e) {
			e.printStackTrace();
			SessionErrors.add(renderRequest, "errorDesconocido" );		

		}
		super.doView(renderRequest, renderResponse);

	}
	
	private void vSeteaFechas(String fechaSeleccionada) {
		dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		cal = Calendar.getInstance();
		if (fechaSeleccionada != null) {
			String aux = "";
			for (char c : fechaSeleccionada.toCharArray()) {
				aux += Character.isDigit(c) ? c : "";
			}
			fechaSeleccionada = aux;
			try {
				cal.setTime(new Date(Long.parseLong(fechaSeleccionada)));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		today = cal.getTime();
		cal.add(Calendar.YEAR, 1); // to get previous year add -1
		nextYear = cal.getTime();
	}


	public static Date sumarDiasAFecha(Date fecha, int dias){
	      Calendar calendar = Calendar.getInstance();
	      calendar.setTime(fecha); 
	      calendar.add(Calendar.DAY_OF_YEAR, dias);  
	      return calendar.getTime(); 
	}
	
}

