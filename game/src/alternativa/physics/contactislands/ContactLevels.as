package alternativa.physics.contactislands {
  import alternativa.physics.Body;
  import alternativa.physics.BodyContact;

  public class ContactLevels {
    private const contacts:Vector.<BodyContact> = new Vector.<BodyContact>();

    public function ContactLevels() {
      super();
    }

    public function init(param1:Vector.<BodyContact>) : void {
      var local2:int = int(param1.length);
      this.contacts.length = local2;
      var local3:int = 0;
      while(local3 < local2) {
        this.contacts[local3] = param1[local3];
        local3++;
      }
    }

    public function clear() : void {
      this.contacts.length = 0;
    }

    public function getStaticLevel(param1:Vector.<BodyContact>, param2:Vector.<Body>) : void {
      var local3:int = 0;
      var local4:BodyContact = null;
      local3 = 0;
      while(local3 < this.contacts.length) {
        local4 = this.contacts[local3];
        if(this.isStaticContact(local4)) {
          param1[param1.length] = local4;
          param2[param2.length] = this.getNonStaticBody(local4);
          this.removeContact(local3);
          local3--;
        }
        local3++;
      }
      local3 = 0;
      while(local3 < this.contacts.length) {
        local4 = this.contacts[local3];
        if(param2.indexOf(local4.body1) >= 0 && param2.indexOf(local4.body2) >= 0) {
          param1[param1.length] = local4;
          this.removeContact(local3);
          local3--;
        }
        local3++;
      }
    }

    private function isStaticContact(param1:BodyContact) : Boolean {
      return !(param1.body1.movable && param1.body2.movable);
    }

    private function getNonStaticBody(param1:BodyContact) : Body {
      if(param1.body1.movable) {
        return param1.body1;
      }
      return param1.body2;
    }

    private function removeContact(param1:int) : void {
      var local2:int = this.contacts.length - 1;
      this.contacts[param1] = this.contacts[local2];
      this.contacts.length = local2;
    }

    public function getNextLevel(param1:Vector.<Body>, param2:Vector.<BodyContact>, param3:Vector.<Body>) : void {
      var local4:int = 0;
      var local5:BodyContact = null;
      local4 = 0;
      while(local4 < this.contacts.length) {
        local5 = this.contacts[local4];
        if(this.isInContactWith(param1,local5)) {
          param2[param2.length] = local5;
          param3[param3.length] = this.getNextLevelBody(local5,param1);
          this.removeContact(local4);
          local4--;
        }
        local4++;
      }
      local4 = 0;
      while(local4 < this.contacts.length) {
        local5 = this.contacts[local4];
        if(param3.indexOf(local5.body1) >= 0 && param3.indexOf(local5.body2) >= 0) {
          param2[param2.length] = local5;
          this.removeContact(local4);
          local4--;
        }
        local4++;
      }
    }

    private function isInContactWith(param1:Vector.<Body>, param2:BodyContact) : Boolean {
      return param1.indexOf(param2.body1) >= 0 || param1.indexOf(param2.body2) >= 0;
    }

    private function getNextLevelBody(param1:BodyContact, param2:Vector.<Body>) : Body {
      if(param2.indexOf(param1.body1) < 0) {
        return param1.body1;
      }
      return param1.body2;
    }

    public function hasContacts() : Boolean {
      return this.contacts.length > 0;
    }
  }
}
