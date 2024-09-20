Feature: Irozuku
  Elegantly add styles to terminal output

  Scenario: Writes a plain string
    When I run `irozuku write <input>`
    Then the resulting value should contain <input>
  
  Examples:
    | input |
    | "We are at the park!" |
    | "Irozuku" |
