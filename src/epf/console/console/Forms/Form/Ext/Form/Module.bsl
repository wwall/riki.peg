
Procedure PressExecuteButton(Button)
	
	Controls.VTDebug.Columns.Clear();
	parseText(Controls.text.GetText(), VTDebug);
	Controls.VTDebug.CreateColumns();
	
EndProcedure

Procedure OnOpen()
	Controls.text.SetText("a");
EndProcedure
