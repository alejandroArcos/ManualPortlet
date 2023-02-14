package com.tokio.cotizador.ManualPortlet.portlet;

import java.io.PrintWriter;

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
import com.tokio.cotizador.Bean.PersonaResponse;
import com.tokio.cotizador.ManualPortlet.constants.CotizadorManualPortletKeys;


@Component(
	    immediate = true,
	    property = {
		        "javax.portlet.name="+ CotizadorManualPortletKeys.PORTLET_NAME,
		        "mvc.command.name=/searchPerson"
	    },
	    service = MVCResourceCommand.class
	)

public class SearchPersonResourceCommand extends BaseMVCResourceCommand{
	@Reference
	CotizadorService _CotizadorService; 
	
	@Override
	protected void doServeResource(ResourceRequest resourceRequest, ResourceResponse resourceResponse)
			throws Exception {
		
		User user = (User) resourceRequest.getAttribute(WebKeys.USER);
		String usuario = user.getScreenName();
		String pantalla = "CotizadorManual";
		String nombrecliente = ParamUtil.getString(resourceRequest, "term");
		System.out.println("busco persona:" + nombrecliente);
		int tipoBusqueda = ParamUtil.getInteger(resourceRequest, "tipoBusqueda");
		
		PersonaResponse respuesta = _CotizadorService.getListaPersonas(nombrecliente, tipoBusqueda, usuario, pantalla);
		
		if(respuesta.getCode() ==0 ){
			Gson gson = new Gson();
			System.out.println("service" + respuesta.getListaPersona() );
			String jsonString = gson.toJson(respuesta.getListaPersona());
			PrintWriter writer = resourceResponse.getWriter();
			writer.write(jsonString);
			
		}
		
	}
	 	
	

}
