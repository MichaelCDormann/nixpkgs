{ lib
, buildPythonPackage
, fetchFromGitHub
, pytestCheckHook
, pythonOlder
, requests
, testfixtures
}:

buildPythonPackage rec {
  pname = "openerz-api";
  version = "0.3.0";
  format = "setuptools";

  disabled = pythonOlder "3.6";

  src = fetchFromGitHub {
    owner = "misialq";
    repo = pname;
    rev = "refs/tags/v${version}";
    hash = "sha256-CwK61StspZJt0TALv76zfibUzlriwp9HRoYOtX9bU+c=";
  };

  propagatedBuildInputs = [
    requests
  ];

  nativeCheckInputs = [
    pytestCheckHook
    testfixtures
  ];

  pythonImportsCheck = [
    "openerz_api"
  ];

  disabledTests = [
    # Assertion issue
    "test_sensor_make_api_request"
  ];

  meta = with lib; {
    description = "Python module to interact with the OpenERZ API";
    homepage = "https://github.com/misialq/openerz-api";
    changelog = "https://github.com/misialq/openerz-api/releases/tag/v${version}";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ fab ];
  };
}
