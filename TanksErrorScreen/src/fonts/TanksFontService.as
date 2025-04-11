package fonts {
  import flash.text.TextFormat;

  public class TanksFontService {
    private static var textFormat:TextFormat = new TextFormat("Tahoma");
    private static var embedFonts:Boolean = false;

    public function TanksFontService() {
      super();
    }

    public static function getTextFormat(param1:int) : TextFormat {
      return new TextFormat(textFormat.font,param1,textFormat.color,textFormat.bold,textFormat.italic,textFormat.underline,textFormat.url,textFormat.target,textFormat.align,textFormat.leftMargin,textFormat.rightMargin,textFormat.indent,textFormat.leading);
    }

    public static function isEmbedFonts() : Boolean {
      return embedFonts;
    }

    public static function setTextFormat(param1:TextFormat, param2:Boolean) : void {
      TanksFontService.textFormat = param1;
      TanksFontService.embedFonts = param2;
    }
  }
}
