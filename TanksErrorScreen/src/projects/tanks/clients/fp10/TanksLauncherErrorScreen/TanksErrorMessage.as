package projects.tanks.clients.fp10.TanksLauncherErrorScreen {
  import flash.display.Sprite;
  import flash.events.TextEvent;
  import mx.utils.StringUtil;
  import projects.tanks.clients.tankslauncershared.service.Locale;

  public class TanksErrorMessage extends Sprite implements ITanksErrorMessage {
    private static const ERROR_UNAVAILABLE_TEST:Vector.<String> = new <String>["В данный момент на сервере ведутся технические работы,<br/>поэтому он недоступен.<br/>" + "Приносим извинения за временные неудобства.<br/>" + "Попробуйте вернуться позднее или выберите другой тестовый сервер: <font color=\'#59ff32\'><u><a href=\"event:http://test.tankionline.com\">test.tankionline.com</a></u></font>","Server is unavailable as it is under maintenance. " + "We apologize for any inconvenience caused.<br/>" + "Please try again later or use another test server: <font color=\'#59ff32\'><u><a href=\"event:http://test.tankionline.com\">test.tankionline.com</a></u></font>","Wegen Wartungsarbeiten ist der Server im Moment nicht erreichbar.<br/>" + "Wir entschuldigen uns für diese vorläufigen Unannehmlichkeiten.<br/>" + "Wiederholen Sie bitte den Versuch zum späteren Zeitpunkt oder gehen Sie in einen anderen Testserver: <font color=\'#59ff32\'><u><a href=\"event:http://test.tankionline.com\">test.tankionline.com</a></u></font>","目前该服务器正在进行技术维护，所以您暂时无法进入。<br/>" + "很抱歉给您造成不便。<br/>" + "请稍后尝试登陆或者进入其他测试服务器：<font color=\'#59ff32\'><u><a href=\"event:http://test.3dtank.com\">test.3dtank.com</a></u></font>","O servidor está indisponível temporariamente<br/> devido à manutenção agendada.<br/>" + "Pedimos desculpas pela inconveniência.<br/>" + "Tente mais tarde ou escolha <font color=\'#59ff32\'><u><a href=\"event:http://test.tankionline.com\">test.tankionline.com</a></u></font>","Serwer jest tymczasowo niedostępny<br/> w związku z zaplanowanymi pracami konserwacyjnymi.<br/>" + "Przepraszamy za ewentualne niedogodności.<br/>" + "Spróbuj ponownie później lub wybierz inny serwer testowy: <font color=\'#59ff32\'><u><a href=\"event:http://test.tankionline.com\">test.tankionline.com</a></u></font>"];
    private static const ERROR_MAX_COUNT_TEST:Vector.<String> = new <String>["Сейчас на сервере находится предельно возможное количество игроков, поэтому он недоступен для новых подключений.<br/>" + "Попробуйте вернуться позднее или выберите другой тестовый сервер: <font color=\'#59ff32\'><u><a href=\"event:http://test.tankionline.com\">test.tankionline.com</a></u></font>","Server has reached its maximum capacity. " + "Please try again later or use another test server: <font color=\'#59ff32\'><u><a href=\"event:http://test.tankionline.com\">test.tankionline.com</a></u></font>","Der Server ist im Moment wegen der hohen Spieleranzahl überlastet und ist für die neuen Anschlüsse nicht zugänglich.<br/>" + "Wiederholen Sie bitte den Versuch zum späteren Zeitpunkt oder gehen Sie in einen anderen Testserver: <font color=\'#59ff32\'><u><a href=\"event:http://test.tankionline.com\">test.tankionline.com</a></u></font>","目前该服务器已经人满，无法承载更多的玩家进入。<br/>" + "请稍后尝试登陆或者选择其他测试服务器登陆：<font color=\'#59ff32\'><u><a href=\"event:http://test.3dtank.com\">test.3dtank.com</a></u></font>","Este servidor alcançou o limite de jogadores. Não há conexões novas disponíveis.<br/>" + "Tente mais tarde ou escolha outro servidor de teste: <font color=\'#59ff32\'><u><a href=\"event:http://test.tankionline.com\">test.tankionline.com</a></u></font>","Na tym serwerze jest już maksymalna liczba graczy. Brak nowych połączeń.<br/>" + "Spróbuj ponownie później lub wybierz inny serwer testowy: <font color=\'#59ff32\'><u><a href=\"event:http://test.tankionline.com\">test.tankionline.com</a></u></font>"];
    private static const ERROR_UNAVAILABLE:Vector.<String> = new <String>["В данный момент на сервере ведутся технические работы,<br/>поэтому он недоступен.<br/>" + "Приносим извинения за временные неудобства.<br/>" + "Попробуйте вернуться позднее или выберите <font color=\'#59ff32\'><u><a href=\"event:{0}\">другой игровой сервер</a></u></font>","Server is unavailable as it is under maintenance. " + "We apologize for any inconvenience caused.<br/>" + "Please try again later or use <font color=\'#59ff32\'><u><a href=\"event:{0}\">another game server</a></u></font>","Wegen Wartungsarbeiten ist der Server im Moment nicht erreichbar.<br/>" + "Wir entschuldigen uns für diese vorläufigen Unannehmlichkeiten.<br/>" + "Wiederholen Sie bitte den Versuch zum späteren Zeitpunkt oder wählen Sie einen <font color=\'#59ff32\'><u><a href=\"event:{0}\">anderen Spielserver aus</a></u></font>","目前该服务器正在进行技术维护，所以您暂时无法进入。<br/>" + "很抱歉给您造成不便。请稍后尝试登陆或者选择登陆 <font color=\'#59ff32\'><u><a href=\"event:{0}\">其他服务器</a></u></font>","O servidor está indisponível temporariamente<br/> devido à manutenção agendada.<br/>" + "Pedimos desculpas pela inconveniência.<br/>" + "Tente mais tarde ou escolha <font color=\'#59ff32\'><u><a href=\"event:{0}\">outro servidor</a></u></font>","Serwer jest tymczasowo niedostępny<br/> w związku z zaplanowanymi pracami konserwacyjnymi.<br/>" + "Przepraszamy za ewentualne niedogodności.<br/>" + "Spróbuj ponownie później lub wybierz <font color=\'#59ff32\'><u><a href=\"event:{0}\">inny serwer gry</a></u></font>"];
    private static const ERROR_MAX_COUNT:Vector.<String> = new <String>["Сейчас на сервере находится предельно возможное количество игроков, поэтому он недоступен для новых подключений.<br/>" + "Попробуйте вернуться позднее или выберите <font color=\'#59ff32\'><u><a href=\"event:{0}\">другой игровой сервер</a></u></font>","Server has reached its maximum capacity. " + "Please try again later or use <font color=\'#59ff32\'><u><a href=\"event:{0}\">another game server</a></u></font>","Der Server ist im Moment wegen der hohen Spieleanzahl überlastet und ist für die neuen Anschlüsse nicht zugänglich.<br/>" + "Wiederholen Sie bitte den Versuch zum späteren Zeitpunkt oder wählen Sie einen <font color=\'#59ff32\'><u><a href=\"event:{0}\">anderen Spielserver aus</a></u></font>","目前该服务器已经人满，无法承载更多的玩家进入。<br/>" + "请稍后尝试登陆或者选择 <font color=\'#59ff32\'><u><a href=\"event:{0}\">其他服务器</a></u></font> 登陆","Este servidor alcançou o limite de jogadores. Não há conexões novas disponíveis.<br/>" + "Tente mais tarde ou escolha <font color=\'#59ff32\'><u><a href=\"event:{0}\">outro servidor</a></u></font>","Na tym serwerze jest już maksymalna liczba graczy. Brak nowych połączeń.<br/>" + "Spróbuj ponownie później lub wybierz <font color=\'#59ff32\'><u><a href=\"event:{0}\">inny serwer gry</a></u></font>"];
    private static const errorMessages:Vector.<Vector.<String>> = new <Vector.<String>>[ERROR_UNAVAILABLE_TEST,ERROR_MAX_COUNT_TEST,ERROR_UNAVAILABLE,ERROR_MAX_COUNT];

    private const OVERLOADED_ERROR:String = "overloaded";
    private const NOTAVAILABLE_ERROR:String = "notavailable";

    private var tew:TankErrorWindow;
    private var tb:TankBackground;

    public function TanksErrorMessage() {
      super();
      mouseEnabled = false;
      tabEnabled = false;
      new TankFont();
      this.tb = new TankBackground();
      addChild(this.tb);
      this.tew = new TankErrorWindow();
      this.tew.addEventListener(TextEvent.LINK,this.onLinkClicked);
      addChild(this.tew);
    }

    private function onLinkClicked(event:TextEvent) : void {
      dispatchEvent(new TextEvent("LINK_CLICKED",true,false,event.text));
    }

    public function init(errorCode:String, isTestServer:Boolean, anotherGameServerUrl:String, locale:String) : void {
      this.tew.init(this.getErrorMessage(errorCode,isTestServer,anotherGameServerUrl,locale),locale);
    }

    public function redraw(stageWidth:int, stageHeight:int) : void {
      this.tew.x = stageWidth - this.tew.width >> 1;
      this.tew.y = stageHeight - this.tew.height >> 1;
      this.tb.redraw(stageWidth,stageHeight);
    }

    private function getErrorMessage(errorCode:String, isTestServer:Boolean, anotherGameServerUrl:String, locale:String) : String {
      var local5:int = errorCode == this.OVERLOADED_ERROR ? 1 : 0;
      local5 += isTestServer ? 0 : 2;
      var local6:String = errorMessages[local5][Locale.LOCALES.indexOf(locale)];
      if(!isTestServer) {
        local6 = StringUtil.substitute(local6,anotherGameServerUrl);
      }
      return local6;
    }
  }
}
