package org.swiftsuspenders {
  import flash.system.ApplicationDomain;
  import flash.utils.*;

  public class Reflector {
    public function Reflector() {
      super();
    }

    public function classExtendsOrImplements(classOrClassName:Object, superclass:Class, application:ApplicationDomain = null) : Boolean {
      var factoryDescription:XML;
      var actualClass:Class = null;
      if(classOrClassName is Class) {
        actualClass = Class(classOrClassName);
      } else if(classOrClassName is String) {
        try {
          actualClass = Class(getDefinitionByName(classOrClassName as String));
        }
        catch(e:Error) {
          throw new Error("The class name " + classOrClassName + " is not valid because of " + e + "\n" + e.getStackTrace());
        }
      }
      if(!actualClass) {
        throw new Error("The parameter classOrClassName must be a valid Class " + "instance or fully qualified class name.");
      }
      if(actualClass == superclass) {
        return true;
      }
      factoryDescription = describeType(actualClass).factory[0];
      return factoryDescription.children().(name() == "implementsInterface" || name() == "extendsClass").(attribute("type") == getQualifiedClassName(superclass)).length() > 0;
    }

    public function getClass(value:*, applicationDomain:ApplicationDomain = null) : Class {
      if(value is Class) {
        return value;
      }
      return getConstructor(value);
    }

    public function getFQCN(value:*, replaceColons:Boolean = false) : String {
      var fqcn:String = null;
      var lastDotIndex:int = 0;
      if(value is String) {
        fqcn = value;
        if(!replaceColons && fqcn.indexOf("::") == -1) {
          lastDotIndex = int(fqcn.lastIndexOf("."));
          if(lastDotIndex == -1) {
            return fqcn;
          }
          return fqcn.substring(0,lastDotIndex) + "::" + fqcn.substring(lastDotIndex + 1);
        }
      } else {
        fqcn = getQualifiedClassName(value);
      }
      return replaceColons ? fqcn.replace("::",".") : fqcn;
    }
  }
}
