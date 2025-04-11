package alternativa.osgi.service.command.impl {
  import alternativa.osgi.service.command.FormattedOutput;

  public class FormattedOutputToString implements FormattedOutput {
    public var content:Vector.<String> = new Vector.<String>();

    public function FormattedOutputToString() {
      super();
    }

    public function addText(param1:String) : void {
      this.content.push(param1);
    }

    public function addPrefixedText(param1:String, param2:String) : void {
      this.addText(param1 + " " + param2);
    }

    public function addLines(param1:Vector.<String>) : void {
      var local2:int = 0;
      while(local2 < param1.length) {
        this.addText(param1[local2]);
        local2++;
      }
    }

    public function addPrefixedLines(param1:String, param2:Vector.<String>) : void {
      var local3:int = 0;
      while(local3 < param2.length) {
        this.addPrefixedText(param1,param2[local3]);
        local3++;
      }
    }
  }
}
