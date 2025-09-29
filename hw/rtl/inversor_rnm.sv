`timescale 1ps/1ps // O 1ps/1ps para máxima precisión. Mantenemos 1ns/1ps como ejemplo.

module inversor_rnm (
    input  real vin,     // Entrada analógica (RNM)
    output real vout    // Salida analógica (RNM)
);

    // Parámetros de la simulación de 180nm
    parameter real VDD   = 1.8;
    parameter real VSS   = 0.0;
    parameter real VTH   = 0.9;
    parameter time T_PLH = 0.199ps;      // Retardo LOW-to-HIGH (propagación)
    parameter time T_PHL = 73.6ps;       // Retardo HIGH-to-LOW (propagación)
    parameter time T_RISE = 67.7ps;     // Tiempo de transición 0 -> 1
    parameter time T_FALL = 65.246ps;      // Tiempo de transición 1 -> 0

    real vin_anterior;
    
    initial begin
        vout = VSS; 
        vin_anterior = VSS;
        $display("[RNM] Inversor listo: T_PHL=%.3f ps, T_PLH=%.3f ps", T_PHL, T_PLH);
    end

    // Monitoreo continuo y aplicación de lógica
    always @(vin) begin
        
        if ((vin >= VTH) && (vin_anterior < VTH)) begin
            
            #T_PHL; // 73.6 ps de retardo antes de que la salida empiece a moverse
            vout <= #(T_FALL) VSS; // Transición de VDD a VSS a lo largo de 65.246 ps
            
        end 
        
        else if ((vin < VTH) && (vin_anterior >= VTH)) begin
            
            #T_PLH; // 0.199 ps de retardo antes de que la salida empiece a moverse
            vout <= #(T_RISE) VDD; // Transición de VSS a VDD a lo largo de 67.7 ps
            
        end

        vin_anterior = vin;

    end
    
endmodule