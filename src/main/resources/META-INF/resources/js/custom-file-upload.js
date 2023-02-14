zip.workerScriptsPath = '/o/com.tokio.cotizador.ManualPortlet/js/';

(function(obj) {
	var requestFileSystem = obj.webkitRequestFileSystem || obj.mozRequestFileSystem || obj.requestFileSystem;

	var fileInput = document.getElementById("file-input");
	var filedrag = document.getElementById("drop-zone");
	var fileList = document.getElementById("file-list");
	//var fileListWrapper = document.getElementById("file-list-wrapper");
	//var downloadButton = document.getElementById("download-button");
	var submitButton = document.getElementById("submit-button");
	var maxFileUpload = 30 * 1024 * 1024 * 1024;

	function onerror(message) {
	    console.log(message);
        fileInput.value = "";
        fileInput.disabled = false;
        //$(downloadButton).show();
    	$(submitButton).show();
	}
	

	function createTempFile(callback) {
	    var tmpFilename = "tmp.zip";
	    requestFileSystem(TEMPORARY, maxFileUpload, function(filesystem) {
	        function create() {
	            filesystem.root.getFile(tmpFilename, {
	                create: true
	            }, function(zipFile) {
	                callback(zipFile);
	            });
	        }

	        filesystem.root.getFile(tmpFilename, null, function(entry) {
	            entry.remove(create, create);
	        }, create);
	    });
	}

	function addFiles(e) {
/*		
		if( $("#tipoArchivo").val() ==0 ){
			showMessageError("#modal-archives" , "Seleccione un tipo de archivo" ,0);
			return;
		}
*/		
	    fileInput.disabled = true;
/*	    $(fileListWrapper).show(); */
	    //$(downloadButton).hide();
	    $(submitButton).hide();
	    var idProgress = Date.now();

	    // cancel event and hover styling
	    fileDragHover(e);

	    // fetch FileList object
	    var files = e.target.files || e.dataTransfer.files;
	    console.log(files);
	    model.addFiles(files, function() {}, function(file) {
	        idProgress++;
	        // create progress bar
	        var bar = createFileStatus(idProgress, file.name); 
	        /*$(fileList).append(bar);*/
	        var tipo = "pdf";
	        /*
	        tipo = $("#tipoArchivo option:selected").text();
	        valor = $("#tipoArchivo").val();*/
	        
	        usuario = $("#usuarioActual").val();
	        $("#DataTables_Table_0 .odd").remove();
/*	        var stringAppend = "<tr> <td>"+file.name+"</td><td>"+usuario+"</td><td>"+new Date()+"</td><td>"+tipo+"</td><td> <i class=\"fa fa-window-close\"> </i> <input type=\"hidden\" class=\"tipoArchivosHidden\" name=\"tipoArchivos[]\" value=\""+valor+"\"> <input type=\"hidden\" name=\"nombreArchivos[]\" class=\"nombreArchivosHidden\" value=\""+file.name+"\">  </td></tr>";*/
/*	        var stringAppend = "<tr>"+ bar +" <td>"+usuario+"</td><td>"+new Date()+"</td><td>"+tipo+"</td><td> <a onclick=\"borraArchivo(this)\"><i class=\"fa fa-window-close\"> </i> </a> <input type=\"hidden\" class=\"tipoArchivosHidden\" name=\"tipoArchivos[]\" value=\""+valor+"\"> <input type=\"hidden\" name=\"nombreArchivos[]\" class=\"nombreArchivosHidden\" value=\""+file.name+"\">  </td></tr>";*/
/*	        var botonBorrar = "  <a onclick=\"borraArchivo(this)\"><i class=\"fa fa-window-close\"> </i> </a> <input type=\"hidden\" class=\"tipoArchivosHidden\" name=\"tipoArchivos[]\" value=\""+valor+"\"> <input type=\"hidden\" name=\"nombreArchivos[]\" class=\"nombreArchivosHidden\" value=\""+file.name+"\">  ";*/
	        var botonBorrar = "  <a onclick=\"borraArchivo(this)\"><i class=\"fa fa-window-close\"> </i> </a>  <input type=\"hidden\" name=\"nombreArchivos[]\" class=\"nombreArchivosHidden\" value=\""+file.name+"\">  ";

	        modalTable.row.add(  
	        		[ file.name ,bar,usuario,fechaHoy(), botonBorrar ]
	        ).draw();
/*	        $("#DataTables_Table_0").append( stringAppend );*/


	    }, function(current, total) {
	        var pc = parseInt((current / total * 100));
	        $("#progress-bar-" + idProgress).width(pc + "%");
	        $("#progress-bar-" + idProgress).html(pc + " %");
	        if (current == total) {
	            $("#progress-bar-" + idProgress).addClass("progress-bar-success");
	        }
	    }, function() {
	        fileInput.value = "";
	        fileInput.disabled = false;
	        //$(downloadButton).show();
	    	$(submitButton).show();
	    });
	}

	function createFileStatus(id, name) {
		/*
	    var status = "<li class='list-group-item'>" +
	        "  <div class='row'>" +
	        "    <div class='col-sm-8'>" + name + "</div>" +
	        "    <div class='col-sm-4'>" +
	        "      <div class='progress'>" +
	        "        <div id='progress-bar-" + id + "' class='progress-bar' role='progressbar' aria-valuenow='0' aria-valuemin='0' aria-valuemax='100' style='width: 0%;'>0%</div>" +
	        "      </div>" +
	        "    </div>" +
	        "  </div>" +
	        "</li>";
	    return status;*/
	    var status = "<td>" +
        "" + name + "</td>" +
        "    <td>" +
        "      <div class='progress'>" +
        "        <div id='progress-bar-" + id + "' class='progress-bar' role='progressbar' aria-valuenow='0' aria-valuemin='0' aria-valuemax='100' style='width: 0%;'>0%</div>" +
        "      </div>" +
        "    </td>";
	    return status;
	}

	function createFileStatusErrorSize(name) {
	    var status = "<li class='list-group-item'>" +
	        "  <div class='row'>" +
	        "    <div class='col-sm-8'>" + name + "</div>" +
	        "    <div class='col-sm-4 text-danger'>Excede tamaño máximo permitido (30 MB)</div>" +
	        "  </div>" +
	        "</li>";
	    return status;
	}

	// file drag hover
	function fileDragHover(e) {
	    e.stopPropagation();
	    e.preventDefault();
	    e.type == "dragover" ? $(e.target).addClass("drop") : $(e.target).removeClass("drop");
	}
	


	function uploadFile(file,filename,idProgress) {
		showLoader();

	    var xhr = new XMLHttpRequest();

	    //if (xhr.upload && file.type == "image/jpeg" && file.size <= $id("MAX_FILE_SIZE").value) {
	    if (xhr.upload) {
	        if (file.size <= maxFileUpload) {

	            //console.log("Subiendo archivo");

	            // create progress bar
/*	            var bar = createFileStatus(idProgress,"Enviando " + filename);
	        	$(fileList).append(bar);*/

	            // progress bar
	            xhr.upload.addEventListener("progress", function(e) {
	                var pc = parseInt((e.loaded / e.total * 100));
	                /*
	                $("#progress-bar-" + idProgress).width(pc + "%");
	                $("#progress-bar-" + idProgress).html(pc + " %");
	                */
	            }, false);

	            // file received/failed
	            xhr.onreadystatechange = function(e) {
	                if (xhr.readyState == 4) {
	                    if (xhr.status == 200) {
	                        fileList.innerHTML = "";
	                        var jsonResponse = JSON.parse(xhr.responseText);
	                        console.log( jsonResponse );
	                        if( jsonResponse.msg == "OK" || jsonResponse.msg == "ok" || jsonResponse.msg == "Ok"  ){
		    			    	mensaje ="";
		                        mensaje += "Su numero de folio es: " + $("#numeroDeFolioX").val();
		                        $("#modalBodyFolio").html( mensaje );
		    					hideLoader();
	                        }else{
		    			    	mensaje ="";
		                        mensaje += "Error al subir archivos: " + jsonResponse.msg + "<br/>";
		                        mensaje += "Su numero de folio es: " + $("#numeroDeFolioX").val();
		                        $("#modalBodyFolio").html( mensaje );
		    					hideLoader();
	                        }
	                        $(submitButton).hide();
	                    } else {
	                    	console.log("Error al cargar");
	    					hideLoader();

	                    }
	                }
	            };

	            // start upload
	            xhr.open("POST", $("#upload").attr('action'), true);
	            xhr.setRequestHeader("X-FILENAME", filename);
	            var formData = new FormData();
	            
	            formData.append("thefile", file);
	            $(".tipoArchivosHidden").each(function( index ) {
		            formData.append("tipoArchivos[]",  $( this ).val() );
	            });
	            $(".nombreArchivosHidden").each(function( index ) {
		            formData.append("nombreArchivos[]",  $( this ).val() );
	            });

	            formData.append("idCotizacion",  $("#idCotizacion").val() );

	            xhr.send(formData);
/*	            xhr.send(file); */

	        } else {
	            var ps = $("#progress-status");
	            var bar = createFileStatusErrorSize(file.name);
	            var progress = $(ps).append(bar);
	        }
	    }
	}

	var model = (function() {
	    var zipFileEntry, zipWriter, writer, creationMethod, URL = obj.webkitURL || obj.mozURL || obj.URL;

	    return {
	        setCreationMethod: function(method) {
	            creationMethod = method;
	        },
	        addFiles: function addFiles(files, oninit, onadd, onprogress, onend) {
	            var addIndex = 0;

	            function nextFile() {
	                var file = files[addIndex];
	                onadd(file);
	                zipWriter.add(file.name, new zip.BlobReader(file), function() {
	                    addIndex++;
	                    if (addIndex < files.length)
	                        nextFile();
	                    else
	                        onend();
	                }, onprogress);
	            }

	            function createZipWriter() {
	                zip.createWriter(writer, function(writer) {
	                    zipWriter = writer;
	                    oninit();
	                    nextFile();
	                }, onerror);
	            }

	            if (zipWriter)
	                nextFile();
	            else if (creationMethod == "Blob") {
	                writer = new zip.BlobWriter();
	                createZipWriter();
	            } else {
	                createTempFile(function(fileEntry) {
	                    zipFileEntry = fileEntry;
	                    writer = new zip.FileWriter(zipFileEntry);
	                    createZipWriter();
	                });
	            }
	        },
	        getBlobURL: function(callback) {
	            zipWriter.close(function(blob) {
	                var blobURL = creationMethod == "Blob" ? URL.createObjectURL(blob) : zipFileEntry.toURL();
	                callback(blobURL);
	                zipWriter = null;
	            });
	        },
	        getBlob: function(callback) {
	        	try {
		        	zipWriter.close(callback);
		            zipWriter = null;
	        	}
	        	catch(err) {
	        	}
	        }
	        
	    };
	})();




	(function() {
	    if (typeof requestFileSystem == "undefined")
	        model.setCreationMethod("Blob"); //File
	    fileInput.addEventListener('change', addFiles,false);

	    var xhr = new XMLHttpRequest();
	    if (xhr.upload) {

	        // file drop
	        filedrag.addEventListener("dragover", fileDragHover, false);
	        filedrag.addEventListener("dragleave", fileDragHover, false);
	        filedrag.addEventListener("drop", addFiles, false);

	    }
	    /*downloadButton.addEventListener("click", function(event) {
	    	var filename = "carga-masiva-" + Date.now() + ".zip";
	        var target = event.target,
	            entry;
	        
            if (typeof navigator.msSaveBlob == "function") {
                model.getBlob(function(blob) {
                    navigator.msSaveBlob(blob, filename);
                });
            } else {
                model.getBlobURL(function(blobURL) {
                    var clickEvent;
                    clickEvent = document.createEvent("MouseEvent");
                    clickEvent.initMouseEvent("click", true, true, window, 0, 0, 0, 0, 0, false, false, false, false, 0, null);
                    downloadButton.href = blobURL;
                    downloadButton.download = filename;
                    downloadButton.dispatchEvent(clickEvent);
                    fileList.innerHTML = "";
                    $(fileListWrapper).hide();
				    $(downloadButton).hide();
				    $(submitButton).hide();
                });
                event.preventDefault();
                return false;
            }
	        
	    }, false);*/

	    submitButton.addEventListener("click", function(event) {
	    	var ts = Date.now();
	    	var filename = "archivo-" + ts + ".zip";
	        var target = event.target,entry;
	        model.getBlob(function(blob){
	        	uploadFile(blob,filename,ts);
	        });
	        event.preventDefault();
	        return false;
	        
	    }, false);
	    

	})();

})(this);

function fechaHoy() {
	var fs = new Date($.now());
	var day = ("0" + (fs.getDate())).slice(-2);
	var month = ("0" + (fs.getMonth() + 1)).slice(-2);
	var fechaFin = (day) + "/" + (month) + "/" + fs.getFullYear() + "  " + fs.getHours() + ":" + fs.getMinutes() + ":" + fs.getSeconds();
	return fechaFin;
}