Add-Type -AssemblyName System.Windows.Forms

# Funktion zum Zufällige ID auswählen und Text aus CSV lesen
function GetRandomText {
    $csvData = Import-Csv "text.csv" -Delimiter ";"
    $maxID = ($csvData | Measure-Object).Count - 1
    $Name = $textBoxName.Text

    $IDLine = Get-Random -Minimum 0 -Maximum $maxID
    $selectedRow = $csvData[$IDLine]

    if ($Global:Gender -eq "m") {
        $Output = $selectedRow.male -replace '\$Name', $Name
    } elseif ($Global:Gender -eq "f") {
        $Output = $selectedRow.female -replace '\$Name', $Name
    }

    $Text = "Story: " + $IDLine + " - " + $Output

    $textBoxOutput.Text = $Text
}

# GUI erstellen
$form = New-Object System.Windows.Forms.Form
$form.Text = "BotCt Kill Story Generator"
$form.Size = New-Object System.Drawing.Size(400,500)
$form.StartPosition = "CenterScreen"

$labelName = New-Object System.Windows.Forms.Label
$labelName.Location = New-Object System.Drawing.Point(10,20)
$labelName.Size = New-Object System.Drawing.Size(40,20)
$labelName.Text = "Name:"
$form.Controls.Add($labelName)

$textBoxName = New-Object System.Windows.Forms.TextBox
$textBoxName.Location = New-Object System.Drawing.Point(100,20)
$textBoxName.Size = New-Object System.Drawing.Size(200,20)
$textBoxName.Font = New-Object System.Drawing.Font("Arial",16)
$textBoxName.Enabled = $true
$form.Controls.Add($textBoxName)

$radioButtonMale = New-Object System.Windows.Forms.RadioButton
$radioButtonMale.Location = New-Object System.Drawing.Point(10,50)
$radioButtonMale.Size = New-Object System.Drawing.Size(80,20)
$radioButtonMale.Text = "Male"
$radioButtonMale.Add_Click({ $Global:Gender = "m" })
$form.Controls.Add($radioButtonMale)

$radioButtonFemale = New-Object System.Windows.Forms.RadioButton
$radioButtonFemale.Location = New-Object System.Drawing.Point(100,50)
$radioButtonFemale.Size = New-Object System.Drawing.Size(80,20)
$radioButtonFemale.Text = "Female"
$radioButtonFemale.Add_Click({ $Global:Gender = "f" })
$form.Controls.Add($radioButtonFemale)

$buttonStart = New-Object System.Windows.Forms.Button
$buttonStart.Location = New-Object System.Drawing.Point(10,80)
$buttonStart.Size = New-Object System.Drawing.Size(80,30)
$buttonStart.Text = "Start"
$buttonStart.Add_Click({ GetRandomText })
$form.Controls.Add($buttonStart)

$labelOutput = New-Object System.Windows.Forms.Label
$labelOutput.Location = New-Object System.Drawing.Point(10,120)
$labelOutput.Size = New-Object System.Drawing.Size(100,20)
$labelOutput.Text = "Output:"
$form.Controls.Add($labelOutput)

$textBoxOutput = New-Object System.Windows.Forms.TextBox
$textBoxOutput.Location = New-Object System.Drawing.Point(10,150)
$textBoxOutput.Size = New-Object System.Drawing.Size(350,300)
$textBoxOutput.Multiline = $true
$textBoxOutput.Font = New-Object System.Drawing.Font("Arial",16)
$textBoxOutput.Name = "textBoxOutput"
$form.Controls.Add($textBoxOutput)

# Start der GUI
$Global:Gender = "m" # Standardgeschlecht
$form.ShowDialog() | Out-Null
