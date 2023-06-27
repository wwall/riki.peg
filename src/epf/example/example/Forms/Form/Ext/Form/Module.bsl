
Procedure PressExecuteButton(Button)
	
	Controls.value.Columns.Clear();
	parseText();
	Controls.value.CreateColumns();
	
EndProcedure

Procedure OnOpen()
	fileName = "..\fixtures\testData_01.txt";
EndProcedure
