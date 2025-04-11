package alternativa.tanks.service.settings.keybinding {
  import alternativa.osgi.service.locale.ILocaleService;
  import flash.ui.Keyboard;
  import flash.utils.Dictionary;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class KeyCodesConverter {
    private static var keyCodeToLabel:Dictionary;

    [Inject]
    public static var localeService:ILocaleService;

    public function KeyCodesConverter() {
      super();
      this.initLabelDictionary();
    }

    public function keyCodeToString(param1:uint) : String {
      var local2:String = keyCodeToLabel[param1];
      return local2 == null ? "" : local2;
    }

    private function initLabelDictionary() : void {
      keyCodeToLabel = new Dictionary();
      keyCodeToLabel[Keyboard.NUMBER_0] = "0";
      keyCodeToLabel[Keyboard.NUMBER_1] = "1";
      keyCodeToLabel[Keyboard.NUMBER_2] = "2";
      keyCodeToLabel[Keyboard.NUMBER_3] = "3";
      keyCodeToLabel[Keyboard.NUMBER_4] = "4";
      keyCodeToLabel[Keyboard.NUMBER_5] = "5";
      keyCodeToLabel[Keyboard.NUMBER_6] = "6";
      keyCodeToLabel[Keyboard.NUMBER_7] = "7";
      keyCodeToLabel[Keyboard.NUMBER_8] = "8";
      keyCodeToLabel[Keyboard.NUMBER_9] = "9";
      keyCodeToLabel[Keyboard.MINUS] = "-";
      keyCodeToLabel[Keyboard.EQUAL] = "=";
      keyCodeToLabel[Keyboard.Q] = "Q";
      keyCodeToLabel[Keyboard.W] = "W";
      keyCodeToLabel[Keyboard.E] = "E";
      keyCodeToLabel[Keyboard.R] = "R";
      keyCodeToLabel[Keyboard.T] = "T";
      keyCodeToLabel[Keyboard.Y] = "Y";
      keyCodeToLabel[Keyboard.U] = "U";
      keyCodeToLabel[Keyboard.I] = "I";
      keyCodeToLabel[Keyboard.O] = "O";
      keyCodeToLabel[Keyboard.P] = "P";
      keyCodeToLabel[Keyboard.A] = "A";
      keyCodeToLabel[Keyboard.S] = "S";
      keyCodeToLabel[Keyboard.D] = "D";
      keyCodeToLabel[Keyboard.F] = "F";
      keyCodeToLabel[Keyboard.G] = "G";
      keyCodeToLabel[Keyboard.H] = "H";
      keyCodeToLabel[Keyboard.J] = "J";
      keyCodeToLabel[Keyboard.K] = "K";
      keyCodeToLabel[Keyboard.L] = "L";
      keyCodeToLabel[Keyboard.Z] = "Z";
      keyCodeToLabel[Keyboard.X] = "X";
      keyCodeToLabel[Keyboard.C] = "C";
      keyCodeToLabel[Keyboard.V] = "V";
      keyCodeToLabel[Keyboard.B] = "B";
      keyCodeToLabel[Keyboard.N] = "N";
      keyCodeToLabel[Keyboard.M] = "M";
      keyCodeToLabel[Keyboard.LEFT] = localeService.getText(TanksLocale.TEXT_KEYBOARD_KEY_LEFT);
      keyCodeToLabel[Keyboard.UP] = localeService.getText(TanksLocale.TEXT_KEYBOARD_KEY_UP);
      keyCodeToLabel[Keyboard.RIGHT] = localeService.getText(TanksLocale.TEXT_KEYBOARD_KEY_RIGHT);
      keyCodeToLabel[Keyboard.DOWN] = localeService.getText(TanksLocale.TEXT_KEYBOARD_KEY_DOWN);
      keyCodeToLabel[Keyboard.NUMPAD_0] = "NumPad 0";
      keyCodeToLabel[Keyboard.NUMPAD_1] = "NumPad 1";
      keyCodeToLabel[Keyboard.NUMPAD_2] = "NumPad 2";
      keyCodeToLabel[Keyboard.NUMPAD_3] = "NumPad 3";
      keyCodeToLabel[Keyboard.NUMPAD_4] = "NumPad 4";
      keyCodeToLabel[Keyboard.NUMPAD_5] = "NumPad 5";
      keyCodeToLabel[Keyboard.NUMPAD_6] = "NumPad 6";
      keyCodeToLabel[Keyboard.NUMPAD_7] = "NumPad 7";
      keyCodeToLabel[Keyboard.NUMPAD_8] = "NumPad 8";
      keyCodeToLabel[Keyboard.NUMPAD_9] = "NumPad 9";
      keyCodeToLabel[Keyboard.NUMPAD_ADD] = "NumPad +";
      keyCodeToLabel[Keyboard.NUMPAD_SUBTRACT] = "NumPad -";
      keyCodeToLabel[Keyboard.NUMPAD_DECIMAL] = "NumPad .";
      keyCodeToLabel[Keyboard.NUMPAD_DIVIDE] = "NumPad /";
      keyCodeToLabel[Keyboard.NUMPAD_ENTER] = "NumPad Enter";
      keyCodeToLabel[Keyboard.LEFTBRACKET] = "[";
      keyCodeToLabel[Keyboard.RIGHTBRACKET] = "]";
      keyCodeToLabel[Keyboard.BACKSLASH] = "\\";
      keyCodeToLabel[Keyboard.SEMICOLON] = ";";
      keyCodeToLabel[Keyboard.QUOTE] = "\'";
      keyCodeToLabel[Keyboard.COMMA] = ",";
      keyCodeToLabel[Keyboard.PERIOD] = ".";
      keyCodeToLabel[Keyboard.SLASH] = "/";
      keyCodeToLabel[Keyboard.PAGE_DOWN] = localeService.getText(TanksLocale.TEXT_KEYBOARD_KEY_PG_DN);
      keyCodeToLabel[Keyboard.PAGE_UP] = localeService.getText(TanksLocale.TEXT_KEYBOARD_KEY_PG_UP);
      keyCodeToLabel[Keyboard.SPACE] = localeService.getText(TanksLocale.TEXT_KEYBOARD_KEY_SPACE);
      keyCodeToLabel[Keyboard.SHIFT] = "Shift";
    }
  }
}
