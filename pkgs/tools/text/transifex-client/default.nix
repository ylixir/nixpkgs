{ stdenv, buildPythonApplication, fetchPypi
, python-slugify, requests, urllib3 }:

buildPythonApplication rec {
  pname = "transifex-client";
  version = "0.13.6";

  propagatedBuildInputs = [
    urllib3 requests python-slugify
  ];

  src = fetchPypi {
    inherit pname version;
    sha256 = "0y6pprlmkmi7wfqr3k70sb913qa70p3i90q5mravrai7cr32y1w8";
  };

  prePatch = ''
    substituteInPlace requirements.txt --replace "urllib3<1.24" "urllib3<2.0"
  '';

  # Requires external resources
  doCheck = false;

  meta = with stdenv.lib; {
    homepage = https://www.transifex.com/;
    license = licenses.gpl2;
    description = "Transifex translation service client";
    maintainers = [ maintainers.etu ];
  };
}
