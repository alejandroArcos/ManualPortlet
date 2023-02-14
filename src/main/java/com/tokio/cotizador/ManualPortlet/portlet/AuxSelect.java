package com.tokio.cotizador.ManualPortlet.portlet;

public class AuxSelect {
	String idObjeto;
	String info;
	
	public AuxSelect(String idObjeto, String info) {
		super();
		this.idObjeto = idObjeto;
		this.info = info;
	}

	public String getIdObjeto() {
		return idObjeto;
	}

	public void setIdObjeto(String idObjeto) {
		this.idObjeto = idObjeto;
	}

	public String getInfo() {
		return info;
	}

	public void setInfo(String info) {
		this.info = info;
	}
	
}
