var VTDebug;
var currentLoger;
#region debugInterface

procedure onEnter(name,args = Undefined) export
	parent = currentLoger;
	currentLoger = parent.Rows.Add();
	currentLoger.type = "enter";
	currentLoger.function = name;
	if typeOf(args) = type("Structure") 
		and args.property("type") 
		and args.type = "debug" then
		
		currentLoger.column = args.position.column;
		currentLoger.line = args.position.line;
		currentLoger.position = args.position.position;
		currentLoger.value = args.args;
	else
		currentLoger.value = args;
	endif;
endprocedure

procedure onExit(name,args = Undefined) export
	currentLoger = currentLoger.parent.Rows.Add();
	currentLoger.type = "exit";
	currentLoger.function = name;
	currentLoger.value = args;
	currentLoger = currentLoger.Parent;
	
endprocedure

procedure onFailure(args) export
	loger = currentLoger.Rows.Add();
	loger.type = "failure";
	loger.function = currentLoger.parent.function;
	loger.value = args;
endprocedure

procedure onSuccess(args) export
	loger = currentLoger.Rows.Add();
	loger.type = "success";
	loger.function = currentLoger.parent.function;
	loger.value = args;
endprocedure

#endregion


function CreateRikiPEG()

	current = new File(ThisObject.UsedFileName);
	result = current.Path + "\rikiPEG.epf";
	return ExternalDataProcessors.Create(result, false);
	
endfunction

function parseText(text, DebugTree) export
	
	VTDebug = new ValueTree;
	VTDebug.Rows.Clear();
	VTDebug.Columns.Clear();
	VTDebug.Columns.Add("type");
	VTDebug.Columns.Add("function");
	VTDebug.Columns.Add("value");
	VTDebug.Columns.Add("position");
	VTDebug.Columns.Add("line");
	VTDebug.Columns.Add("column");
	
	currentLoger = VTDebug.Rows.Add();
	currentLoger.function = "S T A R T";
	settings = new Structure;
	settings.insert("debugObject", ThisObject);
	
	riki = CreateRikiPEG();
	riki.init(settings);
	grammar = new Structure;
	parserZ = riki.matchChar("z");
	parserX = riki.matchChar("x");
	parserY = riki.matchChar("y");
	parser = riki.matchSeq(parserZ, parserX, riki.matchPlus(parserY));
	grammar = riki.Grammar(grammar, "start",parser);
	result = riki.parse(text, grammar);
	
	DebugTree = VTDebug.Copy();
endfunction