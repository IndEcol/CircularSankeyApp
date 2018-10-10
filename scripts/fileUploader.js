function fileUploaderSingleLayer() {
    var fileUpload = document.getElementById("fileInput");
    var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.csv|.txt)$/;
    if (regex.test(fileUpload.value.toLowerCase())) {
        if (typeof (FileReader) != "undefined") {
            var reader = new FileReader();
            reader.onload = function (e) {
                var table = document.createElement("table");
                var flows_in_test = document.getElementById("input_flow_data");
                flows_in_test.textContent = '';

                var rows = e.target.result.split("\n");

                for (var i = 0; i < rows.length; i++) {
                    var row = table.insertRow(-1);             
                    var cell_one = rows[i].split(",")[0];
                    var cell_two = rows[i].split(",")[1];
                    var cell_three = rows[i].split(",")[2];
                    var cell_three_modified = cell_three.slice(0, -1);

                    var data = cell_one + " [" + cell_three_modified + "] " + cell_two + "\n";

                    flows_in_test.textContent += data;

                }
                
            }
            reader.readAsText(fileUpload.files[0]);
        } else {
            alert("This browser does not support HTML5.");
        }
    } else {
        alert("Please upload a valid CSV file.");
    }
}


function fileUploaderMultiLayer() {
    var fileUpload = document.getElementById("fileInput");
    var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.csv|.txt)$/;
    if (regex.test(fileUpload.value.toLowerCase())) {
        if (typeof (FileReader) != "undefined") {
            var reader = new FileReader();
            reader.onload = function (e) {
                var table = document.createElement("table");
                var flows_in_test = document.getElementById("input_flow_data");
                flows_in_test.textContent = '';
               
                var rows = e.target.result.split("\n");
                var cells = rows[0].split(",");
                
                var hearderValue = 0;
                for (var i = 0; i < rows.length - 1; i++) {
                    //alert(rows.length)
                    for (var j = 0; j < cells.length-1; j++) {
                        var row = table.insertRow(-1);
                      
                        var cell_one = rows[i+1].split(",")[0];
                        var cell_two = rows[i+1].split(",")[j+1];
                        var cell_three = rows[hearderValue].split(",")[j+1];
                      
                        if (j == cells.length-2)
                            var cell_two_modified = cell_two.slice(0, -1);
                        else
                            cell_two_modified = cell_two;

                        if (!(cell_one == undefined || cell_one == null || cell_one.length <= 0 || cell_three === undefined || cell_three == null || cell_three.length <= 0)) {
                            //alert(cell_three)
                            if (cell_two_modified == '')
                                cell_two_modified = 0;
                            var data = cell_one + " [" + cell_two_modified + "] " + cell_three + "\n";
                            flows_in_test.textContent += data;
                        }
                        else
                        {
                            hearderValue = i+1;
                            
                        }                           
                        
                    }

                }

            }
            reader.readAsText(fileUpload.files[0]);
        } else {
            alert("This browser does not support HTML5.");
        }
    } else {
        alert("Please upload a valid CSV file.");
    }
}

function chooseFunction() {
    //if (document.getElementById("table_layer").checked)
    //    fileUploaderMultiLayer();
    //else
    //    fileUploaderSingleLayer();

    upload_data();

}


function fileUploaderColor() {
    var fileUpload = document.getElementById("fileNodeProperties");
    var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.csv|.txt)$/;
    if (regex.test(fileUpload.value.toLowerCase())) {
        if (typeof (FileReader) != "undefined") {
            var reader = new FileReader();
            reader.onload = function (e) {
                var table = document.createElement("table");
                var flows_in_test = document.getElementById("input_flow_data_color");
                flows_in_test.textContent = '';

                var rows = e.target.result.split("\n");
                var cells = rows[0].split(",");

                var hearderValue = 0;
                for (var i = 0; i < rows.length - 1; i++) {
                    //alert(rows.length)
                    for (var j = 0; j < cells.length - 1; j++) {
                        var row = table.insertRow(-1);

                        var cell_one = rows[i + 1].split(",")[0];
                        var cell_two = rows[i + 1].split(",")[j + 1];
                        var cell_three = rows[hearderValue].split(",")[j + 1];

                        if (j == cells.length - 2)
                            var cell_two_modified = cell_two.slice(0, -1);
                        else
                            cell_two_modified = cell_two;

                        if (!(cell_one == undefined || cell_one == null || cell_one.length <= 0 || cell_three === undefined || cell_three == null || cell_three.length <= 0)) {
                            //alert(cell_three)
                            if (cell_two_modified == '')
                                cell_two_modified = document.getElementById('txtDFlowColor').value;
                            var data = cell_one + " [" + cell_two_modified + "] " + cell_three + "\n";
                            flows_in_test.textContent += data;
                        }
                        else {
                            hearderValue = i + 1;

                        }

                    }

                }

            }
            reader.readAsText(fileUpload.files[0]);
        } else {
            alert("This browser does not support HTML5.");
        }
    } else {
        alert("Please upload a valid CSV file.");
    }
    
}


function uploadNodeProperties() {
    
    var fileUpload = document.getElementById("node_properties");
    var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.csv|.txt)$/;
    if (regex.test(fileUpload.value.toLowerCase())) {
        if (typeof (FileReader) != "undefined") {
            var reader = new FileReader();
            reader.onload = function (e) {
                var table = document.createElement("table");
                var flows_in_test = document.getElementById("input_node_data");
                flows_in_test.textContent = '';

                var rows = e.target.result.split("\n");
                var cells = rows[0].split(",");

                alert();
                for (var i = 1; i < rows.length - 1; i++) {
                             
                        var cell_one = rows[i].split(",")[0];
                        var cell_two = rows[i].split(",")[1];

                        var cell_three = rows[i].split(",")[2];
                        var cell_four = rows[i].split(",")[3];
                        var cell_five = rows[i].split(",")[4];
                        var cell_six = rows[i].split(",")[5];
                        var cell_seven = rows[i].split(",")[6];

                        var cell_seven_modified = cell_five.slice(0, -1);
                       
                        if (!(cell_one == undefined || cell_one == null || cell_one.length <= 0 || cell_three === undefined || cell_three == null || cell_three.length <= 0)) {
                            
                            if (cell_two == '')
                                var cell_two_modified = document.getElementById('txtDNodeColor').value;
                            var data = cell_one + " [" + cell_two + "] " + " [" + cell_three + "] " + " [" + cell_four + "] " + " [" + cell_five + "] " + " [" + cell_six + "] " + " [" + cell_seven_modified + "] " + "\n";
                            flows_in_test.textContent += data;
                        }

                }

            }
            reader.readAsText(fileUpload.files[0]);
        } else {
            alert("This browser does not support HTML5.");
        }
    } else {
        alert("Please upload a valid CSV file.");
    }
    
}

function upload_data() {
    var fileUpload = document.getElementById("fileInput");
    var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.csv|.txt)$/;
    if (regex.test(fileUpload.value.toLowerCase())) {
        if (typeof (FileReader) != "undefined") {
            var reader = new FileReader();
            reader.onload = function (e) {
                var table = document.createElement("table");
                var flows_in_test = document.getElementById("input_flow_data");
                flows_in_test.textContent = '';

                var rows = e.target.result.split("\n");

                for (var i = 0; i < rows.length; i++) {
                    var row = table.insertRow(-1);
                    var cell_one = rows[i].split(",")[0];
                    var cell_two = rows[i].split(",")[1];
                    var cell_three = rows[i].split(",")[2];
                    var cell_three_modified = cell_three.slice(0, -1);

                    var data = cell_one + " [" + cell_three_modified + "] " + cell_two + "\n";

                    flows_in_test.textContent += data;

                }

            }
            reader.readAsText(fileUpload.files[0]);
        } else {
            alert("This browser does not support HTML5.");
        }
    } else {
        alert("Please upload a valid CSV file.");
    }

}