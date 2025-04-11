package alternativa.tanks.utils {
  import alternativa.osgi.service.clientlog.IClientLog;

  public class Antiflood {
    [Inject]
    public static var clientLog:IClientLog;

    private static var domains:Vector.<String>;
    private static var minChars:int;
    private static var minWords:int;
    private static var bufferSize:int;

    private static const LOG_CHANNEL_NAME:String = "chat";
    private static const nonConsonantLetters:RegExp = /[^bpfvбпфвcgjkqsxzсцзкгхdtдтlлйmnмнrржшщч]/g;
    private static const g1:RegExp = /[bpfvбпфв]+/g;
    private static const g2:RegExp = /[cgjkqsxzсцзкгх]+/g;
    private static const g3:RegExp = /[dtдт]+/g;
    private static const g4:RegExp = /[lлй]+/g;
    private static const g5:RegExp = /[mnмн]+/g;
    private static const g6:RegExp = /[rр]+/g;
    private static const g7:RegExp = /[жшщч]+/g;

    private static var chatMessageCodes:Vector.<Array> = Vector.<Array>([]);

    public function Antiflood() {
      super();
    }

    public static function init(param1:Vector.<String>, param2:int, param3:int, param4:int) : void {
      Antiflood.domains = param1;
      Antiflood.minChars = param2;
      Antiflood.minWords = param3;
      Antiflood.bufferSize = param4;
      clientLog.log(LOG_CHANNEL_NAME,"init: minChars = %1  minWords = %2 bufferSize = %3",Antiflood.minChars,Antiflood.minWords,Antiflood.bufferSize);
    }

    private static function getSoundexKey(param1:String) : String {
      var local4:String = null;
      var local2:String = param1.substr(0,1).toUpperCase();
      param1 = param1.substr(1).toLowerCase().replace(nonConsonantLetters,"");
      param1 = param1.replace(g1,"1").replace(g2,"2").replace(g3,"3").replace(g4,"4").replace(g5,"5").replace(g6,"6").replace(g7,"7");
      var local3:int = 0;
      while(local3 < 10) {
        local4 = local3.toString();
        param1 = param1.replace(RegExp(local4 + "{2,}"),local4);
        local3++;
      }
      if(param1.length > 4) {
        param1 = param1.substr(0,4);
      } else {
        param1 += int(0).toFixed(4 - param1.length).substr(2);
      }
      return local2 + param1;
    }

    public static function isNotFlood(param1:String) : Boolean {
      var local3:Array = null;
      var local4:Number = NaN;
      var local5:Number = NaN;
      var local2:Array = getMessageKeys(param1);
      if(param1.length < minChars && local2.length < minWords) {
        return true;
      }
      if(Antiflood.getLettersIndex(param1) < 0.3 || Antiflood.getUniqueWordsIndex(local2) < 0.59) {
        return false;
      }
      for each(local3 in chatMessageCodes) {
        local4 = Math.max(local2.length,local3.length) / Math.min(local2.length,local3.length);
        if(local4 < 1.5) {
          local5 = compareKeys(local2,local3);
          if(local5 > 0.7) {
            return false;
          }
        }
      }
      return true;
    }

    public static function compareKeys(param1:Array, param2:Array) : Number {
      var local3:Number = 0;
      var local4:int = int(param1.indexOf(param2[0]));
      if(param1.length > 1 && local4 > -1 && local4 < param1.length / 2) {
        param1 = param1.slice(local4);
      }
      var local5:int = Math.min(param1.length,param2.length);
      var local6:int = 0;
      while(local6 < local5) {
        if(param1[local6] == param2[local6]) {
          local3 += 1;
        } else if(local6 > 0 && param1[local6] == param2[local6 - 1]) {
          local3 += 0.5;
        } else if(local6 < local5 - 1 && param1[local6] == param2[local6 + 1]) {
          local3 += 0.5;
        }
        local6++;
      }
      return local3 / local5;
    }

    public static function getMessageKeys(param1:String, param2:Boolean = false) : Array {
      var local5:String = null;
      var local6:Array = null;
      var local7:String = null;
      param1 = cutAllowedSubstring(param1);
      var local3:Array = param1.split(" ");
      var local4:Array = new Array();
      for each(local5 in local3) {
        if(local5 != "") {
          local4.push(local5);
        }
      }
      local6 = [];
      for each(local7 in local4) {
        local6.push(Antiflood.getSoundexKey(local7));
      }
      if(param2 && local6.length > 0 && (local4.length >= minWords || param1.length >= minChars)) {
        chatMessageCodes.push(local6);
        if(chatMessageCodes.length > bufferSize) {
          chatMessageCodes.shift();
        }
      }
      return local6;
    }

    private static function cutAllowedSubstring(param1:String) : String {
      var local2:String = null;
      var local3:String = null;
      for each(local2 in domains) {
        local3 = "(http://|https://)?(www\\.)?" + local2 + "[-a-zA-Z0-9./#%_]+";
        param1 = param1.replace(new RegExp(local3,"gi")," ");
      }
      return param1.replace(/[\s_!@#$%^&*()"'\{\}_=+~,.;:\-\/?\[\]\/]+/g," ");
    }

    private static function getUniqueWordsIndex(param1:Array) : Number {
      var local3:String = null;
      if(param1.length < 1) {
        return 1;
      }
      var local2:Array = new Array();
      for each(local3 in param1) {
        if(local2.indexOf(local3) < 0) {
          local2.push(local3);
        }
      }
      return local2.length / param1.length;
    }

    public static function getLettersIndex(param1:String) : Number {
      var local2:String = param1.replace(/[\s_!@#$%^&*()"'\{\}_=+~,.;:\-\/?\[\]\/]+/g,"");
      return local2.length / param1.length;
    }
  }
}
