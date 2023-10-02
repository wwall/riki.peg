
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
