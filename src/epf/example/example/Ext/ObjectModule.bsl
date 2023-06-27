function CreatePEG()

	current = new File(ThisObject.UsedFileName);
	result = current.Path + "\rikiPEG.epf";
	return ExternalDataProcessors.Create(result, false);
	
endfunction

procedure parseText() export
	
	peg = CreatePEG();
	value.Rows.Clear();
	value.Columns.Clear();
	grammar(peg);
	
EndProcedure



procedure grammar(peg)
	// grammar for file
	// data = (dataElement ?(\,))+
	// dataElement = listOfElement 
    //               | Element
	// listOfElement = \{ listContext \}
	// listContext = Element (\, listContext)?
	//Element = Number 
	//		BinaryString
	//		String
	//Number = [0-9]+(\.[0-9]*)
	//BinaryString = ([0-9]/[A-F])+
	//String = \" Char* \"
	//Char = !\". / \"\"
endprocedure