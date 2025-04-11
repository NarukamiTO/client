package alternativa.tanks.service.impl {
  import alternativa.tanks.service.IPasswordParamsService;

  public class PasswordParamsService implements IPasswordParamsService {
    private var _minPasswordLength:int;
    private var _maxPasswordLength:int;
    private var _forbiddenPasswords:Array;

    public function PasswordParamsService() {
      super();
      this._forbiddenPasswords = ["1234567890","123456789","12345678","1234567","123456","12345","1234","0123","01234","012345","0123456","01234567","012345678","0123456789","9876","98765","987654","9876543","98765432","987654321","9876543210","8765","87654","876543","8765432","87654321","876543210","7654","76543","765432","7654321","76543210","6543","65432","654321","6543210","5432","54321","543210","4321","43210","3210","1111","2222","3333","4444","5555","6666","7777","8888","9999","0000","11111","22222","33333","44444","55555","66666","77777","88888","99999","00000","111111","222222","333333","444444","555555","666666","777777","888888","999999","000000","1111111","2222222","3333333","4444444","5555555","6666666","7777777","8888888","9999999","0000000","11111111","22222222","33333333","44444444","55555555","66666666","77777777","88888888","99999999","00000000","111111111","222222222","333333333","444444444","555555555","666666666","777777777","888888888","999999999","000000000","abcd","Jack"
      ,"1234","snoopy","suzy","spike","1012","1234","pepper ","shelby","12345 ","54321 ","pass ","wolf","john","qqqq","aaaa","ZZZz","asdf","zxcv","asdf","zxcv","asdfgh","zxcvbn","1111","!!!!","4321","$#@!","1234","!@#$","12345","!@#$%","123456","!@#$%^","abcd","ABCD","qwerty1","QWERTY!","1q2w3e4r","1q2w3e","q1w2e3","q1w2e3r4","qweasd","QWEASD","asdzxc","ASDZXC","qweqwe","QWEQWE","asdasd","ASDASD","zxczxc","qwaszx","elite","ELITE","1qwerty","!QWERTY","black","blue","green","grey","yellow","orange","brown","support","Support","Topgun","topgun","help","Lame","hack","hunter","ranger","lamer","Lamer","hacker","Hacker","hack","summer","spring","autumn","winter","sunday","monday","tuesday","wednesda","thursday","friday","saturday","january","february","march","april","june","july","august","september","october","november","december","cool","lucky","korn ","fuck","Honda","mustang","pentium","mouse","stan","soccer","password","diablo","zoom","joker","nofear","unix","home","apache","holly","q3rulez","pass123"
      ,"magnum","mother","father","lisa","janet","helen","chocolate","Matrix","Gold","dollar","pussy","eminem","personal","zippo","jennifer","pepsi","clock","time","good","super","friend","angel","qwer","qwert","qwerty","homer","angle","johan","love","test","1q2w3e4r5t6y","31337","loll","gggg"];
    }

    public function get forbiddenPasswords() : Array {
      return this._forbiddenPasswords;
    }

    public function set forbiddenPasswords(param1:Array) : void {
      this._forbiddenPasswords = param1;
    }

    public function get maxPasswordLength() : int {
      return this._maxPasswordLength;
    }

    public function set maxPasswordLength(param1:int) : void {
      this._maxPasswordLength = param1;
    }

    public function get minPasswordLength() : int {
      return this._minPasswordLength;
    }

    public function set minPasswordLength(param1:int) : void {
      this._minPasswordLength = param1;
    }

    public function isPasswordForbidden(param1:String) : Boolean {
      return param1.length < this._minPasswordLength || this._forbiddenPasswords.indexOf(param1.toLowerCase()) != -1;
    }
  }
}
