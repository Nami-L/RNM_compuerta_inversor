`timescale 1ps / 1ps // ¡PRECISIÓN ALTA!

module inversor_rnm (
    input  real vin,     // Entrada analógica (RNM)
    output real vout    // Salida analógica (RNM)
);

    // Parámetros de la simulación de 180nm
    parameter real VDD   = 1.8;
    parameter real VSS   = 0.0;
    parameter real VTH   = 0.9;
    //TPHL
    //Significado: Es el tiempo que tarda la salida de un circuito lógico
    //en cambiar de un nivel alto (High o 1) a un nivel bajo (Low o 0) 
    //después de que ha ocurrido un cambio en la entrada que provoca esa transición
    //TPLH
    //Significado: Es el tiempo que tarda la salida de un circuito lógico en 
    //cambiar de un nivel bajo (Low o 0) a un nivel alto 
    //High o 1) después de que ha ocurrido un cambio en la entrada que provoca esa transición.
    parameter time T_PLH = 0.199ps;      
    parameter time T_PHL = 73.6ps;       
    
    parameter time T_RISE = 67.7ps;   // Tiempo de subida (rampa)  cuando la señal esta en su %10 y %90
    parameter time T_FALL = 65.246ps;   /// Tiempo de bajada (rampa)   

    real vin_anterior;
    
    initial begin
       // vout = VSS; 
       // vin_anterior = VSS;
        $display("[RNM] Inversor listo: T_PHL=%.3f ps, T_PLH=%.6f ps", T_PHL, T_PLH);
    end

 assign vout = (vin < VTH) ? VDD : VSS;


 sde

endmodule
