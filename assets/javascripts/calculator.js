$(function() {
    $('#calculator-form').submit(function(event){
       event.preventDefault();
        $.ajax({
            url: "/calculator",
            type: "POST",
            data: {
                grossRent: $("#gross-rent").val(),
                lettingsService: $("#lettings-service").val(),
                managementService: $("#management-service").val(),
                maintenanceAndRepairs: $("#maintenance-and-repairs").val(),
                voids: $("#voids").val(),
                additionalFees: $("#additional-fees").val(),
            },
            success: function(response){
                $("#calculation-results").html(response);
            }
        })
    });
});
