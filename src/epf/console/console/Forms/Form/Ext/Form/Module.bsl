
Procedure PressExecuteButton(Button)
	
	Controls.VTDebug.Columns.Clear();
	parseText(Controls.text.GetText(), VTDebug);
	Controls.VTDebug.CreateColumns();
	
EndProcedure

Procedure OnOpen()
	Controls.text.SetText("zxyyy");
EndProcedure

Procedure VTDebugOnActivateRow(Control)
	updatePosition(control.CurrentData);
	updateData(control.CurrentData)
EndProcedure


Procedure updateData(row)

	dataVT.Rows.Clear();
	if row.value = undefined then
		return;
	endif;
	
	addElement(dataVT, key, row.value);
	
EndProcedure

Procedure updatePosition(row)
	positionVT.Clear();
	writeKeyValue(positionVT.Add(), "function", row.function);
	writeKeyValue(positionVT.Add(), "type", row.type);
	writeKeyValue(positionVT.Add(), "line", row.line);
	writeKeyValue(positionVT.Add(), "column", row.column);
	writeKeyValue(positionVT.Add(), "position", row.position);
	
EndProcedure

procedure writeKeyValue(row, key, value);
	row.key = key;
	row.value = value;
endprocedure

Procedure writeStructure(dest, data)
	
	for each kv in data do
		addElement(dest, kv.key, kv.value);
	enddo;
	
endprocedure


procedure addElement(dest, key, value)
	
	row = dest.rows.add();
	row.key = key;
	
	ss  = 1;
	
	if typeof(value) = type("Structure") then
		writeStructure(row, value);
	elsif typeof(value) = type("Array") then
		index = 0;
		for each x in value do
			addElement(row, StrTemplate("[%1]", index), x);
			index = index + 1;
		enddo;
	else
		row.value = value;
	endif;

endprocedure

