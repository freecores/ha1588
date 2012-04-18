//change this file for different test case
initial
begin
  @ start_test;
  command_addr = 'h20;  //write address start from 0x0
  byte_enable = '1;  //all byte lanes are used
  idle = 0;  //no idle cycle between each command of the master BFM
  init_latency = 0;  //the command is launched to Avalon bus with no delay
  
  //First write NUM_TRANS of random data to the DUT
  for (int i = 0; i < `NUM_TRANS; i++) 
  begin
    command_data = {$random()} % 8;
	master_scoreboard.push_back(command_data); //make a local copy of the write data
    master_set_and_push_command(REQ_WRITE, command_addr, command_data, byte_enable, idle, init_latency);
	command_addr = command_addr + 4;
  end   
  
  //Next read back the data
  command_addr = 'h20;
  for (int i = 0; i < `NUM_TRANS; i++)
  begin    
    master_set_and_push_command(REQ_READ, command_addr, 0, byte_enable, idle, init_latency);
	command_addr = command_addr + 4;
  end
end
