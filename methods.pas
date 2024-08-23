unit methods;

interface

uses
  Vcl.Forms;

type
  TSetesForms = class
  public
    /// <summary> Call the form
    /// </summary>
    /// <param name="FormClass">Enter the form class here. Example: TSeaCity
    /// </param>
    class procedure Show(FormClass: TFormClass);
  end;

implementation

class procedure TSetesForms.Show(FormClass: TFormClass);
var
  Lc_form: TForm;
begin
  Lc_form := FormClass.Create(nil);
  try
    Lc_form.ShowModal;
  finally
    Lc_form.DisposeOf;
  end;
end;

end.
