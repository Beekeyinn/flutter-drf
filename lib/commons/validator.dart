class Validator
{
  static bool ifEmpty(String s)
  {
    if(s.trim() == '')
      {
        return true;
      }
    return false;
  }
}