//change this file to perform different test result checkng function
always @ go_check
begin
  checked++;
    
  if(response_request == REQ_READ)
  begin    
	expected_data = master_scoreboard.pop_front(); //get the expected data which was saved earlier
		
	if(response_data != expected_data)
	begin
	  failure++;
	  $sformat(message, "%m: Data mismatch at %0h: %0h with expected %0h\n", response_addr, response_data, expected_data);	       
	  print(VERBOSITY_FAILURE, message);
	end		
  end
end
