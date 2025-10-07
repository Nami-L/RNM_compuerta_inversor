`timescale 1ps / 1ps 

module tb_inversor_rnm;

    parameter real VDD = 1.8;
    parameter real VSS = 0.0;
    parameter time MED_PERIODO = 50ns; 
    parameter time TIEMPO_PASO = 10ps;
    parameter int CICLOS = 5;      
    
        real vin;
    real vout;
    logic vout_int;
    // Instanciar el inversor 
    inversor_rnm DUT (
        .vin(vin),
        .vout(vout)
    );
      assign vout_int = vout > 0.9 ? 1 : 0;

    initial begin
        $monitor("T=%t | Vin=%.3fV | Vout=%.3f", $realtime, vin, vout);
        $display("=== [TB] Iniciando simulación de precisión ===");
        
        vin = VSS; // Inicio en 0V
    
            repeat (CICLOS) begin
            subir_voltaje(VSS, VDD, TIEMPO_PASO); 
            
            #MED_PERIODO; 
            
            bajar_voltaje(VDD, VSS, TIEMPO_PASO);
            
            #MED_PERIODO; 
        end
        
        $display("\n[%t] === Simulación completada ===", $realtime);
        $finish;
    end
    
    task subir_voltaje(input real inicio, input real fin, input time duracion);
        real paso;
        int num_pasos = 10; 
        paso = (fin - inicio) / num_pasos;
        
        for (int i = 0; i <= num_pasos; i++) begin
            vin = inicio + i * paso;
                        #(duracion / num_pasos); 

            
        end
    endtask
    
    task bajar_voltaje(input real inicio, input real fin, input time duracion);
        real paso;
        int num_pasos = 10;
        paso = (inicio - fin) / num_pasos;
        
        for (int i = 0; i <= num_pasos; i++) begin
            vin = inicio - i * paso;
                        #(duracion / num_pasos);

            
        end
    endtask

    initial begin
        $timeformat(-12, 3, " ps", 12);
          $fsdbDumpvars; 
    end

endmodule

