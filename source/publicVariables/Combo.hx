package publicVariables;

class Combo {
   public static var combo:Int = 0;

   public static function resetCombo()
   {
     combo = 0;
   }

   public static function addCombo()
   {
     combo++;
   }

   public static function returnCombo()
   {
     return combo;
   }
}