package alternativa.osgi.service.console {
  import alternativa.osgi.service.command.FormattedOutput;
  import alternativa.osgi.service.console.variables.ConsoleVar;

  public interface IConsole extends FormattedOutput {
    function show() : void;
    function hide() : void;
    function isVisible() : Boolean;
    function setSize(param1:int, param2:int) : void;
    function set width(param1:int) : void;
    function get width() : int;
    function set height(param1:int) : void;
    function get height() : int;
    function set horizontalAlignment(param1:int) : void;
    function get horizontalAlignment() : int;
    function set vericalAlignment(param1:int) : void;
    function get vericalAlignment() : int;
    function set alpha(param1:Number) : void;
    function get alpha() : Number;
    function setCommandHandler(param1:String, param2:Function) : void;
    function removeCommandHandler(param1:String) : void;
    function executeCommand(param1:String) : void;
    function addVariable(param1:ConsoleVar) : void;
    function removeVariable(param1:String) : void;
  }
}
