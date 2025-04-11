package alternativa.osgi.service.command {
  public interface FormattedOutput {
    function addText(param1:String) : void;
    function addPrefixedText(param1:String, param2:String) : void;
    function addLines(param1:Vector.<String>) : void;
    function addPrefixedLines(param1:String, param2:Vector.<String>) : void;
  }
}
