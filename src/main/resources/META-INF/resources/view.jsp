<%@ include file="./init.jsp"%>
<%@ taglib prefix="liferay-ui" uri="http://liferay.com/tld/ui"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!-- Acciones del portlet para comunicar vista con el controler -->
<portlet:actionURL name="datosCotManual" var="datosCotManual" />

<portlet:resourceURL id="/getUserDocuments" var="getUserDocuments" >
</portlet:resourceURL>

<portlet:resourceURL id="/searchPerson" var="searchPersonURL" >
	<portlet:param name="tipoBusqueda" value="1" />
</portlet:resourceURL>

<portlet:resourceURL id="/searchPerson" var="searchRFCURL" >
	<portlet:param name="tipoBusqueda" value="3" />
</portlet:resourceURL>

<portlet:resourceURL id="/submitForm" var="submitForm" >
</portlet:resourceURL>


<liferay-ui:success key="consultaExitosa" message="cotizacion.exito" />
<liferay-ui:error key="errorConocido" message=" ${errorMsg}" />
<liferay-ui:error key="errorDesconocido" message="cotizacion.erorDesconocido" />


<section class="site-wrapper upper-case-all">
	<header></header>
	<section id="landing-agentes">
		<div class="section-heading">
			<div class="container-fluid">
				<h4 class="title text-left">
					<liferay-ui:message key="ManualPortlet.titCotMan"/> V 1.0
				</h4>
			</div>
		</div>




		<div class="container">
			<form id="frmCotizadorManual" name="frmCotizadorManual" method="post" action="<%=datosCotManual%>">
				<h5>
					<liferay-ui:message key="ManualPortlet.titDatCon"/>
				</h5>
				<br />
				<div class="row">
					<div class="col-md-12">
						<div class="form-inline" id="divRdoTpClient">
							<div class="form-check ">
								<input class="form-check-input" name="<portlet:namespace/>group20" type="radio" id="radio1_ce" checked="checked" value="0">
								<label class="form-check-label" for="radio1_ce">
									<liferay-ui:message key="ManualPortlet.lblClientEx"/>
								</label>
							</div>
							<div class="form-check">
								<input class="form-check-input" name="<portlet:namespace/>group20" type="radio" id="radio2_cn" value="1">
								<label class="form-check-label" for="radio2_cn">
									<liferay-ui:message key="ManualPortlet.lblClientNue"/>
								</label>
							</div>

						</div>
					</div>
				</div>

				<div class="row" id="data_cteext">
					<div class="col-sm-3">
						<div class="md-form form-group">
							<input type="text" id="rfcPersona" name="<portlet:namespace/>rfcContraCteExt" class="form-control validaTxtClExis"> 
							<label for="rfcPersona">
								<liferay-ui:message key="ManualPortlet.lblRfcContra"/>
							</label>
						</div>
					</div>
					<div class="col-sm-6">
						<div class="md-form form-group">
							<input id="nomComCteExt" type="text" name="<portlet:namespace/>nomComCteExt" class="form-control validaTxtClExis">
							<label for="nomComCteExt">
								<liferay-ui:message key="ManualPortlet.lblNomCom"/>
							</label>
							<input type="hidden" name="nombreHidden" id="nombreHidden" value="">
							<input type="hidden" name="appPaternoHidden" id="appPaternoHidden" value="">
							<input type="hidden" name="appMaternoHidden" id="appMaternoHidden" value="">
							<input type="hidden" name="idPersonaHidden" id="idPersonaHidden" value="">
							<input type="hidden" name="tipOperHidden" id="tipOperHidden" value="">
							<input type="hidden" name="idDenominacionHidden" id="idDenominacionHidden" value="">
							
							
						</div>
					</div>
					<div class="col-sm-3">
						<div class="md-form form-group">
							<input type="text" name="codCteExt" class="form-control" readonly="readonly" id="codCteExt">
							<input type="text" name="<portlet:namespace/>codCteExtOc" hidden="hidden" id="codCteExtOc">
							<label for="codCteExt">
								<liferay-ui:message key="ManualPortlet.lblCodClien"/>
							</label>
						</div>
					</div>
				</div>

				<div class="row" id="data_ctenvo" style="display: none">
					<div class="col-sm-12">
						<div class="row">
							<div class="col-sm-6">
								<div class="md-form form-group">
									<input type="text" name="<portlet:namespace/>nomComCteNvo" class="form-control" readonly="readonly" id="nomComCteNvo">
									<label for="nomComCteNvo">
										<liferay-ui:message key="ManualPortlet.lblNomCom"/>
									</label>
								</div>
							</div>
							<div class="col-sm-6">
								<div class="form-inline" id="divRdoTpPer">
									<div class="form-check">
										<input class="form-check-input" name="<portlet:namespace/>persona" type="radio" id="fisica" value="1" checked="checked">
										<label class="form-check-label" for="fisica">
											<liferay-ui:message key="ManualPortlet.lblPerFis"/>
										</label>
									</div>
									<div class="form-check">
										<input class="form-check-input" name="<portlet:namespace/>persona" type="radio" id="moral" value="2">
										<label class="form-check-label" for="moral">
											<liferay-ui:message key="ManualPortlet.lblPerMor"/>
										</label>
									</div>
								</div>
							</div>
						</div>
						<div class="row" id="fisicarow">
							<div class="col-sm-3">
								<div class="md-form form-group">
									<input id="rfcNvFisic" type="text" name="<portlet:namespace/>rfcNvFisic" class="form-control validaTxtClNvoFis" >
									<label for="rfcNvFisic">
										<liferay-ui:message key="ManualPortlet.lblRfcContra"/>
									</label>
								</div>
							</div>
							<div class="col-sm-3">
								<div class="md-form form-group">
									<input type="text" name="<portlet:namespace/>nomNvFisic" class="form-control llenaNomFis validaTxtClNvoFis" id="nomNvFisic">
									<label for="nomNvFisic">
										<liferay-ui:message key="ManualPortlet.lblNom"/>
									</label>
								</div>
							</div>
							<div class="col-sm-3">
								<div class="md-form form-group">
									<input type="text" name="<portlet:namespace/>apPatNvFisic" class="form-control llenaNomFis validaTxtClNvoFis" id="apPatNvFisic">
									<label for="apPatNvFisic">
										<liferay-ui:message key="ManualPortlet.lblApPat"/>
									</label>
								</div>
							</div>
							<div class="col-sm-3">
								<div class="md-form form-group">
									<input type="text" name="<portlet:namespace/>apMatNvFisic" class="form-control llenaNomFis validaTxtClNvoFis" id="apMatNvFisic">
									<label for="apMatNvFisic">
										<liferay-ui:message key="ManualPortlet.lblApMat"/>
									</label>
								</div>
							</div>
						</div>
						<div class="row" id="moralrow" style="display: none">
							<div class="col-sm-3">
								<div class="md-form form-group">
									<input type="text" name="<portlet:namespace/>rfcNvoMoral" id="rfcNvoMoral"class="form-control validaTxtClNvoMor">
									<label for="rfcNvoMoral">
										<liferay-ui:message key="ManualPortlet.lblRfcContra"/>
									</label>
								</div>
							</div>
							<div class="col-sm-6">
								<div class="md-form form-group">
									<input type="text" name="<portlet:namespace/>nomNvMoral" class="form-control llenaNomMor validaTxtClNvoMor" id="nomNvMoral">
									<label for="nomNvMoral">
										<liferay-ui:message key="ManualPortlet.lblNomContr"/>
									</label>
								</div>
							</div>
							<div class="col-sm-3">
								<div class="md-form form-group">
									<select name="<portlet:namespace/>estNvMor" class="mdb-select colorful-select dropdown-primary llenaNomMorSel validaSelClNvoMor"
									 id="estNvMor" searchable='<liferay-ui:message key="ModuloComisionesPortlet.buscar" />'>
										<option value="-1" selected><liferay-ui:message key="ManualPortlet.selectOpDefoult"/></option>
										<c:forEach items="${listaDenominacion}" var="opc">
											<option value="${opc.idCatalogoDetalle}">${opc.valor}</option>
										</c:forEach>
									</select>
									<label for="estNvMor">
										<liferay-ui:message key="ManualPortlet.lblDenom"/>
									</label>
								</div>
							</div>
						</div>
					</div>
				</div>

				<br />
				<h5><liferay-ui:message key="ManualPortlet.titDatCot"/></h5>
				<br />
				<div class="row" style="text-align: right">
					<div class="col-sm-12">
						<div id="divRdoVigencia" class="form-inline form-right">
							<span><strong><liferay-ui:message key="ManualPortlet.spVig"/></strong></span>
							<div class="form-check">
								<input class="form-check-input" name="group21" type="radio" id="radio3_cv" checked="checked" value="0">
								<label class="form-check-label" for="radio3_cv">
									<liferay-ui:message key="ManualPortlet.lblCotConVig"/>
								</label>
							</div>
							<div class="form-check">
								<input class="form-check-input" name="group21" type="radio" id="radio4_cv" value="1">
								<label class="form-check-label" for="radio4_cv">
									<liferay-ui:message key="ManualPortlet.lblVigAnuParSolEm"/>
								</label>
							</div>
						</div> 
					</div>
				</div>

				<div class="row">
					<div class="col-sm-3">
						<div class="md-form form-group">
							<select id="tipoMovimiento" name="<portlet:namespace/>tipoMovimiento" class="mdb-select validaSelCotiza">
								<option value="-1" selected><liferay-ui:message key="ManualPortlet.selectOpDefoult"/></option>
								<c:forEach items="${listaTipoMov}" var="opc">
									<option value="${opc.idCatalogoDetalle}">${opc.valor}</option>
								</c:forEach>
							</select>
							<label for="estatus">
								<liferay-ui:message key="ManualPortlet.lblTipoMov"/>
							</label>
						</div>
					</div>
					<div id="numeroPolizaId" class="col-sm-3">
						<div class="md-form form-group">
							<input type="text" name="<portlet:namespace/>poliza" class="form-control validaTxtCotiza" id="folioTMX">
							<label for="folioTMX">
								<liferay-ui:message key="ManualPortlet.lblPoliza"/>
							</label>
						</div>
					</div>
					<div class="col-sm-6">
						<div class="md-form form-group">
							<div class="row">
								<div class="col">
									<label for="modoCotizacion" class="active">
										<liferay-ui:message key="ManualPortlet.lblDesde"/>
									</label>
									<input placeholder="Desde" type="text" id="dateDesde" name="<portlet:namespace/>dateDesde" class="form-control datepicker" value="${fechaHoy}" />
								</div>
								<div class="col">
									<input placeholder="Hasta" type="text" id="dateHasta" class="form-control datepicker " disabled value="${nextAnio}"/>
									<input type="hidden" class="validaTxtClExis" id="dateHasta2" name="<portlet:namespace/>dateHasta" value="${nextAnio}"/>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-md-3">
						<div class="md-form form-group">
							<select name="<portlet:namespace/>agente" class="mdb-select validaSelCotiza colorful-select dropdown-primary"
							 searchable='<liferay-ui:message key="ModuloComisionesPortlet.buscar" />' >
    	                   		<c:if test="${fn:length(listaAgente) > 1}">
									<option value="-1" selected><liferay-ui:message key="ManualPortlet.selectOpDefoult"/></option>
								</c:if>
							 
								<c:forEach items="${listaAgente}" var="opc">
									<option value="${opc.idPersona}">${opc.nombre} ${opc.appPaterno} ${opc.appMaterno} </option>
								</c:forEach>
							</select>
							<label for="estatus">
								<liferay-ui:message key="ManualPortlet.lblAgentes"/>
							</label>
						</div>
					</div>
					<div class="col-md-3">
						<div class="md-form form-group">
							<select name="<portlet:namespace/>moneda" class="mdb-select validaSelCotiza">
								<option value="-1" selected><liferay-ui:message key="ManualPortlet.selectOpDefoult"/></option>
								<c:forEach items="${listaMoneda}" var="opc">
									<option value="${opc.idCatalogoDetalle}">${opc.valor}</option>
								</c:forEach>
							</select>
							<label for="estatus">
								<liferay-ui:message key="ManualPortlet.lblMoneda"/>
							</label>
						</div>
					</div>
					<div class="col-md-3">
						<div class="md-form form-group">
							<select name="<portlet:namespace/>formaPago" class="mdb-select validaSelCotiza">
								<option value="-1" selected><liferay-ui:message key="ManualPortlet.selectOpDefoult"/></option>
								<c:forEach items="${listaPago}" var="opc">
									<option value="${opc.idCatalogoDetalle}">${opc.valor}</option>
								</c:forEach>
							</select>
							<label for="estatus">
								<liferay-ui:message key="ManualPortlet.lblForPag"/>
							</label>
						</div>
					</div>
					<div class="col-md-3">
						<div class="md-form form-group">
							<select name="<portlet:namespace/>producto" class="mdb-select validaSelCotiza">
								<option value="-1" selected><liferay-ui:message key="ManualPortlet.selectProducto"/></option>
								<c:forEach items="${listaProducto}" var="opc">
									<option value="${opc.idCatalogoDetalle}">${opc.valor}</option>
								</c:forEach>
							</select>
							<label for="estatus">
								<liferay-ui:message key="ManualPortlet.tituloProducto"/>
							</label>
						</div>
					</div>
					<div class="col-md-10">
                            <div class="md-form form-group">
                                <textarea maxlength="500" id="materialFormContactMessageEx" name="<portlet:namespace/>textoMensaje" id="menTxt" class="form-control md-textarea validaTxtCotiza" rows="3"></textarea>
                                <label for="materialFormContactMessageEx">Mensaje</label>
                            </div>
                    </div>
					<div class="col-md-2">
						<div class="md-form form-group">
							<a class="btn btn-blue btn-sm btn-primary" data-toggle="modal" href="#modal-archives"><i class="far fa-file-alt mr-2"></i><span> <liferay-ui:message key="ManualPortlet.btnSubArch"/> </span></a>
						</div>
					</div>
				</div>



				<div class="row">
					<div class="col-sm-12" style="text-align: right">
						<button type="submit" class="btn btn-pink">Enviar</button>
<!-- 						<a class="btn btn-pink">Enviar</a> -->
					</div>
				</div>
			</form>
		</div>


<!-- inicio Modal no funciona -->

	                <div class="form-group" style="display: none;">
	                  <label></label>
	                  <div class="upload-drop-zone" id="drop-zone">
	                    Sólo arrastra y suelta los archivos a subir
	                  </div>
	                </div>


<input id="usuarioActual" type="hidden" value="${usuario}">


<!-- fin Modal no funciona -->

		<!-- Modal Ver archivos -->
		<div class="modal" id="modal-archives" tabindex="-1" role="dialog"
			aria-labelledby="archivesLabel" aria-hidden="true"
		>
			<div class="modal-dialog modal-lg modal-dialog-centered" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="archivesLabel"><liferay-ui:message key="ManualPortlet.titArc"/></h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
                    	<form id="upload" action="<%= getUserDocuments %>">
                    		<input type="hidden" name="idCotizacion" id="idCotizacion" value="">
                    		<input type="hidden" name="numeroDeFolioX" id="numeroDeFolioX" value="">
							
							<h5><liferay-ui:message key="ManualPortlet.titSelArc"/></h5>
							<br />
							<div class="row">
							<%-- 
								<div class="col-sm-12 col-md-3">
                                    <div class="md-form form-group">
										<select id="tipoArchivo" name="tipoArchivo" class="mdb-select">
												<option value="0"> Seleccione una opcion</option>
											 <c:forEach items="${listaTipoArchivo}" var="opc">
											 
												<option value="${opc.idCatalogoDetalle}">${opc.valor}</option>
                                             </c:forEach>
										</select>
										<label for="tipoArchivo">
											<liferay-ui:message key="ManualPortlet.lblTipArc"/>
										</label>
									</div>									
								</div>
								 --%>							
								<div class="col-sm-12 col-md-6">
									<div class="md-form form-group">
										<div class="file-loading">
											<input id="file-input" name="inputFolder" type="file" multiple>
										</div>
										<div id="kartik-file-errors"></div>
									</div>
								</div>
								<div class="col-sm-12 col-md-3" style="display:none;">
									<div class="md-form form-group">
										<button id="submit-button" type="button" class="btn btn-pink btn-rounded btn-sm waves-effect waves-light float-right"><liferay-ui:message key="ManualPortlet.btnAgArc"/></button>
									</div>
								</div>
							</div>
						</form>
						<table class="table simple-data-table table-striped table-bordered" style="width: 100%;">
							<thead>
								<tr>
									<th>Archivo</th>
									<th>Progreso</th>
									<th>Usuario de creación</th>
									<th>Fecha de creación</th>
									<th class="all" data-orderable="false"></th>
								</tr>
							</thead>
                            <tbody id="file-list">
                            
							</tbody>
						</table>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-blue btn-sm btn-secondary" data-dismiss="modal"><liferay-ui:message key="ManualPortlet.btnCerrar"/></button>
					</div>
				</div>
			</div>
		</div>
		<!-- END Modal Ver archivos -->		

		
		
		<div class="modal" id="modal-folio" tabindex="-1" role="dialog"
			aria-labelledby="archivesLabel" aria-hidden="true"
		>
			<div class="modal-dialog modal-lg modal-dialog-centered" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="archivesLabel"><liferay-ui:message key="ManualPortlet.tituloResultado"/></h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body" id="modalBodyFolio">
						
						
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-blue btn-sm btn-secondary" data-dismiss="modal" onclick="reload()" ><liferay-ui:message key="ManualPortlet.btnCerrar"/></button>
					</div>
				</div>
			</div>
		</div>
		<!-- END Modal Ver folio -->
		
		
		<div class="modal" id="modal-folio2" tabindex="-1" role="dialog"
			aria-labelledby="archivesLabel" aria-hidden="true"
		>
			<div class="modal-dialog modal-lg modal-dialog-centered" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="archivesLabel"><liferay-ui:message key="ManualPortlet.tituloResultado"/></h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body" id="modalBodyFolio2">
						
						
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-blue btn-sm btn-secondary" data-dismiss="modal" onclick="reload()" ><liferay-ui:message key="ManualPortlet.btnCerrar"/></button>
					</div>
				</div>
			</div>
		</div>
		<!-- END Modal Ver folio 2-->
		
<!-- Modal usuario existente -->
<div class="modal" id="modalClienteExistente" tabindex="-1" role="dialog" aria-labelledby="clienteExistenttLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="clienteExistenttLabel">
					<liferay-ui:message key="ModuloEmpresarialPortlet.titModClientExistt" />
				</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<!--Body-->
			<div class="modal-body">

				<div class="row">
					<div class="col-12">
						<h4 class="font-weight-bold">
							<samp id="nombreClienteExistt"></samp>						
						</h4>
						<liferay-ui:message key="ModuloEmpresarialPortlet.infoModClientExistt" />
					</div>
				</div>
			</div>

			<!--Footer-->
			<div class="modal-footer justify-content-center">
				<div class="row">
					<div class="col-md-6">
						<button class="btn btn-pink waves-effect waves-light" id="btnClienttExisttSi" >Si</button>
					</div>
					<div class="col-md-6">
						<button class="btn btn-blue waves-effect waves-light" id="btnClienttExisttNo" >No</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- END Modal usuario existente -->
		
		
		
		
		
		<footer class="text-center text-md-left pt-4 mt-4 border-top border-info"></footer>

	</section>
</section>



<script src="<%=request.getContextPath()%>/js/zip.js"></script>    
<script src="<%=request.getContextPath()%>/js/zip-ext.js"></script>    
<script src="<%=request.getContextPath()%>/js/jquery-ui.min.js"></script>    
<script src="<%=request.getContextPath()%>/js/custom-file-upload.js"></script>    
    
<script type="text/javascript">


function borraArchivo(e){
	modalTable.row( $(e).parents('tr') ).remove().draw();
	
}


$(document).ready(function(){
	
	
    /* autocomplete Nombre*/
	$( "#nomComCteExt" ).autocomplete({
	      minLength: 3,
	      source: "<%= searchPersonURL %>",
	      focus: function( event, ui ) {
	        $( "#nomComCteExt" ).val( ui.item.nombrepersona );
	        return false;
	      },
	      select: function( event, ui ) {
	        $( "#nomComCteExt" ).val( ui.item.nombre + " "+ ui.item.appPaterno+" "+ ui.item.appMaterno  );
	        $( "#rfcPersona" ).val( ui.item.rfc );
	        $( "#codCteExt" ).val( ui.item.codigo );
	        $( "#codCteExtOc" ).val( ui.item.codigo );
			$("#nombreHidden").val( ui.item.nombre );
			$("#appPaternoHidden").val( ui.item.appPaterno );
			$("#appMaternoHidden").val( ui.item.appMaterno );
			$("#idPersonaHidden").val( ui.item.idPersona );
			$("#tipOperHidden").val( ui.item.tipOper );
			$("#idDenominacionHidden").val( ui.item.idDenominacion );
			
	        
	        $( "#nomComCteExt" ).parent().children("label").addClass("active");
	        $( "#rfcPersona" ).parent().children("label").addClass("active");
	        $( "#codCteExt" ).parent().children("label").addClass("active");
	 
	        return false;
	      }
	    }).autocomplete( "instance" )._renderItem = function( ul, item ) {
			console.log( item );
			if( item.idDenominacion == 0 ){
			      return $( "<li>" )
			        .append( "<div>" + item.nombre + " "+ item.appPaterno +" " + item.appMaterno + "</div>" )
			        .appendTo( ul );
			}else{
			      return $( "<li>" )
			        .append( "<div>" + item.nombre  + " "+ item.appPaterno +" " + item.appMaterno +  "</div>" )
			        .appendTo( ul );
				
			}

	    };		
	    /* autocomplete RFC*/
	    $( "#rfcPersona" ).autocomplete({
		      minLength: 3,
		      source: "<%= searchRFCURL %>",
		      focus: function( event, ui ) {
		        $( "#nomComCteExt" ).val( ui.item.nombrepersona );
		        return false;
		      },
		      select: function( event, ui ) {
		        $( "#nomComCteExt" ).val( ui.item.nombre + " "+ ui.item.appPaterno+" " + ui.item.appMaterno );
		        $( "#rfcPersona" ).val( ui.item.rfc );
		        $( "#codCteExt" ).val( ui.item.codigo );
		        $( "#codCteExtOc" ).val( ui.item.codigo );
				$("#nombreHidden").val( ui.item.nombre );
				$("#appPaternoHidden").val( ui.item.appPaterno );
				$("#appMaternoHidden").val( ui.item.appMaterno );
				$("#idPersonaHidden").val( ui.item.idPersona );
				$("#tipOperHidden").val( ui.item.tipOper );
				$("#idDenominacionHidden").val( ui.item.idDenominacion );
		        
		        
		        $( "#nomComCteExt" ).parent().children("label").addClass("active");
		        $( "#rfcPersona" ).parent().children("label").addClass("active");
		        $( "#codCteExt" ).parent().children("label").addClass("active");
		 
		        return false;
		      }
		    }).autocomplete( "instance" )._renderItem = function( ul, item ) {
				console.log( item );
				if( item.idDenominacion == 0 ){
				      return $( "<li>" )
				        .append( "<div>" + item.rfc+":" + item.nombre + " "+ item.appPaterno +" " + item.appMaterno + "</div>" )
				        .appendTo( ul );
				}else{
				      return $( "<li>" )
				        .append( "<div>" + item.rfc+":" + item.nombre + "</div>" )
				        .appendTo( ul );
					
				}

		    };	
		    
			var fechMin = '${hoyServidor}';
			$('#dateDesde').pickadate({ 
				format: 'yyyy-mm-dd',
	 		    formatSubmit: 'yyyy-mm-dd',
				min: fechMin
				
			});
	

});


</script>



<script type="text/javascript">


	function reload(){
		location.reload();
	}
	var clickButton = false;


	$('#divRdoTpClient .form-check-input').click(function(){
	 	if ( $(this).val()=="1")
	 	{
	 		$("#data_ctenvo").show();
	 		$("#data_cteext").hide();		
	 	}else{
	 		$("#data_ctenvo").hide();
	 		$("#data_cteext").show();
	 	}

	});
	
	$('#divRdoTpPer .form-check-input').click(function(){
	 	if ( $(this).val()=="1")
	 	{
	 		$("#fisicarow").show();
	 		$("#moralrow").hide();
	 		fLlenaNombreFisica();
	 	}else{
	 		$("#fisicarow").hide();
	 		$("#moralrow").show();
	 		fLlenaNombreMoral();
	 	}
	});
	
	/* tipo de vigencia y fechas */
	$("#divRdoVigencia .form-check-input").click(function() {
		if ($(this).val() == "1") {
/*			$("#dateDesde").prop("disabled", true);*/
			$('#ddateDesde').val("");
			$('#dateHasta').val("");
			$('#dateHasta2').val("");
			muestraocultaCampoas($('#dateDesde'), false);
			muestraocultaCampoas($('#dateHasta'), false);
			fechaHoy();
		} else {
			$("#dateDesde").prop("disabled", false);
			muestraocultaCampoas($('#dateDesde'), true);
			muestraocultaCampoas($('#dateHasta'), true);
/*			fechaHoy();*/
		}
	});

	function fechaHoy() {
		var fs = new Date($.now());
		var day = ("0" + (fs.getDate())).slice(-2);
		var month = ("0" + (fs.getMonth() + 1)).slice(-2);
		var fechaFin = fs.getFullYear() + "-" + (month) + "-" + (day);
		$('#dateDesde').val(fechaFin);
		fs.setDate((fs.getDate() - 1));
		genAnioSiguiente(fs);
	}

	$('#dateDesde').change(function() {
		if ($(this).val() != "") {
			/*var dateSelect = new Date($(this).val());*/
			genAnioSiguiente($(this).val());
		} else {
			$('#dateDesde').val("");
			$('#dateHasta').val("");
			$('#dateHasta2').val("");
		}
	});

	/**
	 * @param {Date} fechaSeleccionada
	 */
	function genAnioSiguiente(fechaSeleccionada) {
		var fecha = fechaSeleccionada.split("-");
		var fs = new Date(parseInt(fecha[0]), (parseInt(fecha[1]) -1), parseInt(fecha[2]));
		console.log(fs);
		if((fs.getDate() == 29) && (fs.getMonth() == 1)){
			fs.setDate(28);	
		}
		fs.setFullYear(fs.getFullYear() + 1);
		console.log(fs);
		var day = null;
		var month = null;		
		day = ("0" + (fs.getDate())).slice(-2);
		month = ("0" + (fs.getMonth() + 1)).slice(-2);		
		var fechaFin = (fs.getFullYear()) + "-" + (month) + "-" + (day);
		$('#dateHasta').val(fechaFin);
		$('#dateHasta2').val(fechaFin);
	}
	 
	 function muestraocultaCampoas(campo, visible) {
			if (visible) {
				$(campo).parent().removeAttr('hidden');
			} else {
				$(campo).parent().prop('hidden', true);
			}
		}
	
	$('#fisicarow .llenaNomFis').keyup(function() {
		fLlenaNombreFisica();
		
	});
	
	$('#moralrow .llenaNomMor').keyup(function() {
		fLlenaNombreMoral();
	});
	
	$('#moralrow .llenaNomMorSel').change(function() {
		fLlenaNombreMoral();
	});
	
	function fLlenaNombreFisica() {
		var nom = $("#nomNvFisic").val();
		var apPat = $("#apPatNvFisic").val();
		var apMat = $("#apMatNvFisic").val();
		$("#nomComCteNvo").val(nom + " " + apPat + " " + apMat);
		if( !$("#nomComCteNvo").parent().children("label").hasClass("active") ){
			$("#nomComCteNvo").parent().children("label").addClass("active");	
		}
	};
	
	function fLlenaNombreMoral() {
		var nom = "";
		var sel = "";
		
		if(valIsNullOrEmpty($("#nomNvMoral").val())){
			nom = "";
		}else{
			nom = $("#nomNvMoral").val() + ", ";
		}
		
		if(valIsInvalidSelect($("#estNvMor").val())){
			sel = "";
		}else{
			sel = $("#estNvMor option:selected").text().trim();
		}
		
		$("#nomComCteNvo").val(nom + sel);
		if( !$("#nomComCteNvo").parent().children("label").hasClass("active") ){
			$("#nomComCteNvo").parent().children("label").addClass("active");	
		}
		
	};
	
	function valIsNullOrEmpty(value) {
		return (value == null || value === "");
	};

	function valIsInvalidSelect(value) {
		return (value === '-1');
	};
	
	$('#frmCotizadorManual').submit(function(e) {
		e.preventDefault();
		showLoader();
		$(".text-danger").remove();
		rdodtsContr = chkRdodtsContr($('#divRdoTpClient .form-check-input'));
		var errores = false;
		if(rdodtsContr == '0'){
			errores = (vaciosTxt($('.validaTxtClExis')) ? true : errores );
		}else{
			var tipPer = chkRdodtsContr($('#divRdoTpPer .form-check-input'));
			if(tipPer == '1'){
				console.log(errores);
				errores = (vaciosTxt($('.validaTxtClNvoFis')) ? true : errores );
			}else{
				errores = (vaciosTxt($('.validaTxtClNvoMor')) ? true : errores );
				errores = (noSelect($('.validaSelClNvoMor')) ? true : errores );
			}
		}
		errores = (vaciosTxt($('.validaTxtCotiza')) ? true : errores );
		errores = (noSelect($('.validaSelCotiza')) ? true : errores );
		console.log(errores);
		if(!errores){

			$.post('<%= submitForm %>', $('#frmCotizadorManual').serialize() )
			 .done(function(data) {
			    console.log("data");
			    console.log(data);
			    var respuestaJson = JSON.parse( data);
			    if( respuestaJson.code == 0 ){
			    	console.log("Envio archivos");
			    	$("#idCotizacion").val( respuestaJson.idCotizacion );
			    	$("#numeroDeFolioX").val( respuestaJson.folio );
			    	console.log(  respuestaJson.msg);

			    	$("#submit-button").trigger( "click" );
			    	mensaje ="";
                    mensaje += "Su numero de folio es: " + respuestaJson.folio;
                    $("#modalBodyFolio").html( mensaje );
                    $("#modal-folio").show();
/*			    	showMessageSuccess(".navbar", mensaje,0);*/
					hideLoader();
			    }else{
			    	mensaje ="";
                    mensaje += "Error al procesar solicitud: " + respuestaJson.msg + "<br/>";
                    mensaje += "Su numero de folio es: " + respuestaJson.folio;
                    $("#modalBodyFolio").html( mensaje );
                    $("#modal-folio").show();

/*                    showMessageError(".navbar", mensaje,0);*/
					hideLoader();
/*					
					setTimeout(function() {
						window.location.reload();
					}, 5000);
*/
			    }
			  });
		}else{
			hideLoader();
		}
	});
	
	function chkRdodtsContr(rdoBtons){
		var res = null;
		$.each(rdoBtons,function(index, value) {
			if($(value).is(':checked')){
				res = $(value).val();
				return false;
			}
		});
		return res;
	};
	
	function vaciosTxt(campos){
		var errores = false;
		$.each(campos,function(index, value) {
			if (valIsNullOrEmpty($(value).val())) {
				errores = true;
				$(value).parent().append("<div class=\"text-danger\"> <span class=\"glyphicon glyphicon-ban-circle\"></span> El campo es requerido</div>");
			}
		});
		return errores;
	};
	
	function noSelect(campos){
		var errores = false;
		$.each(campos,function(index, value) {
			if (valIsInvalidSelect($(value).val())) {
				errores = true;
				$(value).parent().append("<div class=\"text-danger\"> <span class=\"glyphicon glyphicon-ban-circle\"></span> El campo es requerido</div>");
			}
		});
		return errores;
	};
	
	/*
	$('#dateDesde').change(function() {
		var dateMod = $("#dateDesde").val();
		var dateSplit = dateMod.split("-");
		var anioNuevo = parseInt(dateSplit[0]) + 1;
		var mesNuevo = parseInt(dateSplit[1]) - 1;
		var myDate = new Date(anioNuevo, mesNuevo, parseInt(dateSplit[2]));

		var day = ("0" + myDate.getDate()).slice(-2);
		var month = ("0" + (myDate.getMonth() + 1)).slice(-2);
		var today = myDate.getFullYear() + "-" + (month) + "-" + (day);
		$('#dateHasta').val(today);
		$('#dateHasta2').val(today);
		$('#inpFechaFin').val(today);
		});
	*/
	/*$(document).ready(function(){
		var myDate = new Date();
		var res = myDate.getFullYear() + "," + myDate.getMonth() + "," + myDate.getDate();
		
		var fechMin = ${hoyServidor};
		console.log(fechMin);
		$('#dateDesde').pickadate({ 
			format: 'yyyy-mm-dd',
 		    formatSubmit: 'yyyy-mm-dd',
			min: fechMin
			
		});
	});*/
	
/*__________________________fin de funciones nuestras-----------------------------*/

$('#btn-add-tab').click(function() {
	tabID++;
	if(tabID < 11){				
		$('#tab-list').append($('<li><a id="in_tab'+tabID+'" href="#tab' + tabID + '" role="tab" data-toggle="tab"><i class="fa fa-map-marker" aria-hidden="true"></i> ' + tabID + '<button class="close" type="button" title="Remove this page">×</button></a></li>'));					
		$('#tab-content').append($('<div class="tab-pane fade" id="tab' + tabID + '"> 1 </div>'));
		$("#tab"+ tabID).load("tab_ad_hogar.html");
		
		 time_tabs = setTimeout(function(){ 
		 var tab_id = $("#tit_tab").parent().attr('id');
			$("#tit_tab").attr("id","tit_tab_"+tab_id);
			$("#tit_tab_"+tab_id).html("Datos del riesgo: "+ tabID);			
			$("#save_tot").attr("id","save_tot_"+ tabID);
			$("#checkbox70").attr("id","checkbox70_"+tabID);
			$('#tab'+tabID+' .mdb-select').material_select();
		}, 500);
		var tabShow = $('#tab-list a#in_tab'+tabID);
		tabShow.tab('show');	
		sum_ubicacion(0);
	}
	else
	{alert("No se pudeden agragar más ubicaciones")}
});

$('#tab-list').on('click', '.close', function() {
	var tabID = $(this).parents('a').attr('href');
	$(this).parents('li').remove();
	$(tabID).remove();
	var id_tbl = tabID.substring(1);
	$("#i_"+id_tbl).remove();
	$("#s_"+id_tbl).remove();
	var tabFirst = $('#tab-list a:first');
	resetTab();
	sum_ubicacion(1);
	tabFirst.tab('show');
});
								
var button='<button class="close" type="button" title="Remove this page">×</button>';
var tabID = 1;


$("#tipoMovimiento").on("change", function(){
	valor = $(this).val();
	if( valor == 207 ){
		$("#numeroPolizaId").hide();
		$("#folioTMX").removeClass("validaTxtCotiza");
	}else{
		$("#numeroPolizaId").show();
		$("#folioTMX").addClass("validaTxtCotiza");
	}
});


/* ------- verifica si existe el cliente --- cliente nuevo ------*/

$('#rfcNvFisic').on('blur', function() {
	verificaClienteExistenteRFC($(this).val().trim());
});

$('#rfcNvoMoral').on('blur', function() {
	verificaClienteExistenteRFC($(this).val().trim());
});

function rfcGenerico(rfc){
	if(rfc.toUpperCase() == 'XAXX010101000'){
		return null;
	}
	if(rfc.toUpperCase() == 'XEXX010101000'){
		return null;
	}
	return rfc;
}

function verificaClienteExistenteRFC(rfc){
	infoClientExistenttEncontrado = null;
	rfc = rfcGenerico(rfc);
	if(!valIsNullOrEmpty(rfc)){
		showLoader();
		$.post( '<%= searchRFCURL %>' , {term: rfc }, function(data) {
			if (data.length > 0) {
				$.each(data, function(key, registro) {
					if(registro.rfc === rfc){
						infoClientExistenttEncontrado = registro;
						return false;
					}
				});
				if(infoClientExistenttEncontrado != null){
					$('#nombreClienteExistt').text(infoClientExistenttEncontrado.rfc + ' - ' +
							infoClientExistenttEncontrado.nombre + ' ' + infoClientExistenttEncontrado.appPaterno + ' ' +
							infoClientExistenttEncontrado.appMaterno);
					$('#modalClienteExistente').modal('show');
				}
			}else{
				infoClientExistenttEncontrado = null;
			}
		}, "Json");
		hideLoader();
	}
}


$('#modalClienteExistente').on('hidden.bs.modal', function() {
	if(!clickButton){
		pressBtnNo();
	}
	clickButton = false;
});

$('#btnClienttExisttSi').click(function() {
	clickButton = true;
	$('#radio1_ce').trigger('click');
	$("#nomComCteExt").val(infoClientExistenttEncontrado.nombre + " " + infoClientExistenttEncontrado.appPaterno + " " + infoClientExistenttEncontrado.appMaterno );
	$("#rfcPersona").val(infoClientExistenttEncontrado.rfc);
	$("#codCteExtOc").val(infoClientExistenttEncontrado.codigo);
	$("#codCteExt").val(infoClientExistenttEncontrado.codigo);
	$("#idPersonaHidden").val(infoClientExistenttEncontrado.idPersona);
	$("#tipOperHidden").val(infoClientExistenttEncontrado.tipoPer);
	$("#idDenominacionHidden").val(infoClientExistenttEncontrado.idDenominacion);
	
	$("#nomComCteExt").parent().children("label").addClass("active");
	$("#rfcPersona").parent().children("label").addClass("active");
	$("#codCteExt").parent().children("label").addClass("active");
	
	$('#modalClienteExistente').modal('hide');
	$('#rfcNvFisic').val('');
	$('#rfcNvoMoral').val('');
});



$('#btnClienttExisttNo').click(function() {
	pressBtnNo();
});

function pressBtnNo(){
	clickButton = true;
	if($('#moral').is(':checked')){
		$('#rfcNvoMoral').val('');
		$('#rfcNvoMoral').focus();
	}else{
		$('#rfcNvFisic').val('');	
		$('#rfcNvFisic').focus();
	}
	$('#modalClienteExistente').modal('hide');
}






</script>
