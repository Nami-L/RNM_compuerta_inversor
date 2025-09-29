`timescale 1ps / 1ps // ¡PRECISIÓN MÁXIMA! Unidad y resolución en 1 picosegundo

module tb_inversor_rnm;

    // Parámetros de Simulación (para claridad)
    parameter real VDD = 1.8;
    parameter real VSS = 0.0;
    parameter time HALF_PERIOD = 50ns; // Meseta estable: 50ns
    parameter time STEP_TRANSITION_TIME = 10ps; // Tiempo ultrarrápido para el step de VIN
    parameter int NUM_CYCLES = 6;      
    
        real vin;
    real vout;
    
    // Instanciar el inversor RNM (asegúrate de que tu RTL usa los retardos de propagación)
    inversor_rnm DUT (
        .vin(vin),
        .vout(vout)
    );
    
    // --- 1. Generación de Estímulos y Secuencia Principal ---
    initial begin
        
        $display("=== [TB] Iniciando simulación de precisión ===");
        
        vin = VSS; // Inicio en 0V
        #30ps;    // Pequeño retardo de estabilización
        
        // Ejecutamos 4 ciclos completos de subida/bajada de VIN
        repeat (NUM_CYCLES  ) begin
 // 1. Pulso de Entrada SUBIDA (Step Forzado)
            bajar_voltaje(VSS, VDD, STEP_TRANSITION_TIME); 
            
            #HALF_PERIOD; // Meseta de 50ns ALTO (Estabilidad)
            
            // 2. Pulso de Entrada BAJADA (Step Forzado)
            subir_voltaje(VDD, VSS, STEP_TRANSITION_TIME);
            
            #HALF_PERIOD; // Meseta de 50ns BAJO (Estabilidad)
        end
        
        $display("\n[%t] === Simulación completada ===", $realtime);
        $finish;
    end
    
    task subir_voltaje(input real inicio, input real fin, input time duracion);
        real paso;
        int num_pasos = 10; // Aumentamos los pasos para una rampa más suave
        paso = (fin - inicio) / num_pasos;
        
        for (int i = 0; i <= num_pasos; i++) begin
            // Genera el valor de voltaje
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
