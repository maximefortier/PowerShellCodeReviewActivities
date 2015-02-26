#*************************************************************************************************
#
#		Name: New-PowerShellCodeReviewReport.ps1
#		Description: This Powershell Script generates a Code Review Report for PowerShell Scripts
#                    leveraging  the PowerShell Script Analyzer available in the 
#                    Windows Management Framework 5.0. 
#		Author: Maxime Fortier
#		Version 1.0
#
#*************************************************************************************************


Function CreatePowerShellCodeReviewReport ($ScriptToAnalyze, $ReportPath)
{
    $a = "<style>"
    $a = $a + "BODY{font-family: Calibri, Arial, sans-serif;}"
    $a = $a + "TABLE{border-width: 1px;border-style: solid;border-color: black;border-collapse: collapse;}"
    $a = $a + "TH{border-width: 1px;padding: 1px;border-style: solid;border-color: black;background-color:DimGray}"
    $a = $a + "TD{border-width: 1px;padding: 1px;border-style: solid;border-color: black;background-color:LightGrey}"
    $a = $a + "</style>"
    $b = "<H2>PowerShell Code Review Checklist</H2>"
    $GetDateValue = Get-Date
    $b = $b + "<H4>Report generated on " + $GetDateValue + "<br>PowerShell script analyzed: " + $AnalyzedScriptPath + "</H4>" 

    Invoke-ScriptAnalyzer -Path $AnalyzedScriptPath | Select RuleName, Severity, Line, Message | Sort-Object RuleName, Severity, Line  | ConvertTo-HTML -head $a -body $b | Out-File $ReportPath
}

$CodeReviewReportPath = "D:\Reports\SamplePowerShellCodeReviewReport.html"
$AnalyzedScriptPath = "D:\TFS\SampleSetup.ps1"
CreatePowerShellCodeReviewReport -ScriptToAnalyze $AnalyzedScriptPath -ReportPath $CodeReviewReportPath