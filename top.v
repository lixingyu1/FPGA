module top (
    input               clk,
    input               rstn,

    output reg          led, 
    output              tx
);
reg    [4:0]       state;
reg    [7:0]   tx_data;
reg            tx_en;
wire           flag;
reg   [11:0]      data;

always @(posedge clk or negedge rstn) begin
    if(!rstn)
        tx_en <= 0;
    else 
        tx_en <= 1;
end

always @(posedge clk or negedge rstn) begin
    if(!rstn)
        data <= 0;
    else
        data <= 1543; 
end

always @(posedge clk or negedge rstn)
    if(!rstn)begin
        tx_data <= 0;
    end
    else
        case (state)
            0 : begin
                if(data / 1000 == 1)
                    tx_data <= "1";
                else if(data / 1000 == 2)
                    tx_data <= "2";
                else if(data / 1000 == 3)
                    tx_data <= "3";
                else if(data / 1000 == 4)
                    tx_data <= "4";
                else if(data / 1000 == 5)
                    tx_data <= "5";
                else if(data / 1000 == 6)
                    tx_data <= "6";
                else if(data / 1000 == 7)
                    tx_data <= "7";
                else if(data / 1000 == 8)
                    tx_data <= "8";
                else if(data / 1000 == 9)
                    tx_data <= "9";
                else
                    tx_data <= "0";
            end
            1 : begin
                if((data / 100 % 10) == 1)
                    tx_data <= "1";
                else if((data / 100 % 10) == 2)
                    tx_data <= "2";
                else if((data / 100 % 10) == 3)
                    tx_data <= "3";
                else if((data / 100 % 10) == 4)
                    tx_data <= "4";
                else if((data / 100 % 10) == 5)
                    tx_data <= "5";
                else if((data / 100 % 10) == 6)
                    tx_data <= "6";
                else if((data / 100 % 10) == 7)
                    tx_data <= "7";
                else if((data / 100 % 10) == 8)
                    tx_data <= "8";
                else if((data / 100 % 10) == 9)
                    tx_data <= "9";
                else
                    tx_data <= "0";
            end
            2 : begin
                if((data / 10 % 10) == 1)
                    tx_data <= "1";
                else if((data / 10 % 10) == 2)
                    tx_data <= "2";
                else if((data / 10 % 10) == 3)
                    tx_data <= "3";
                else if((data / 10 % 10) == 4)
                    tx_data <= "4";
                else if((data / 10 % 10) == 5)
                    tx_data <= "5";
                else if((data / 10 % 10) == 6)
                    tx_data <= "6";
                else if((data / 10 % 10) == 7)
                    tx_data <= "7";
                else if((data / 10 % 10) == 8)
                    tx_data <= "8";
                else if((data / 10 % 10) == 9)
                    tx_data <= "9";
                else
                    tx_data <= "0";
            end
            3 : begin
                if((data  % 10) == 1)
                    tx_data <= "1";
                else if((data  % 10) == 2)
                    tx_data <= "2";
                else if((data  % 10) == 3)
                    tx_data <= "3";
                else if((data  % 10) == 4)
                    tx_data <= "4";
                else if((data  % 10) == 5)
                    tx_data <= "5";
                else if((data  % 10) == 6)
                    tx_data <= "6";
                else if((data  % 10) == 7)
                    tx_data <= "7";
                else if((data  % 10) == 8)
                    tx_data <= "8";
                else if((data  % 10) == 9)
                    tx_data <= "9";
                else
                    tx_data <= "0";
            end
            4 : tx_data <= "\n";
        endcase


always @(posedge clk or negedge rstn) begin
    if(!rstn)
        led <= 1;
    else
        led <= 0;
end

always @(posedge clk or negedge rstn) begin
    if(!rstn)
        state <= 0;
    else if(state == 0 && flag == 1)
        state <= 1;
    else if(state == 1 && flag == 1)
        state <= 2;
    else if(state == 2 && flag == 1)
        state <= 3;
    else if(state == 3 && flag == 1)
        state <= 4;
    else if(state == 4 && flag == 1)
        state <= 0;
end
  
always @(posedge clk or negedge rstn) begin
    
end



uart
#(
    .UART_BPS   (9600),         //串口波特率
    .CLK        (50_000_000)    //时钟频率
)uart_inst
(
    .clk       (clk),   //系统时钟50MHz
    .rstn      (rstn),   //全局复位
    .pi_data   (tx_data)  ,   //模块输入的8bit数据
    .pi_flag   (tx_en) ,   //并行数据有效标志信号
 
    .tx        (tx) ,     //串转并后的1bit数据
    .end_flag  (flag)
);

endmodule //top