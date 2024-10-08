Feature: Registro de Dueños de Mascotas

  Scenario: Registrar un dueño de mascota con todos los datos válidos
    Given el veterinario está en la página de registro de dueños de mascotas
    When el veterinario ingresa "John" en el campo First Name
    And el veterinario ingresa "Doe" en el campo Last Name
    And el veterinario ingresa "123 Main St" en el campo Address
    And el veterinario ingresa "Springfield" en el campo City
    And el veterinario ingresa "1234567890" en el campo Telephone
    And el veterinario hace clic en el botón Add Owner
    Then el sistema debería mostrar el mensaje "New Owner Created" y los datos del dueño agregado
    And muestra el texto "John Doe" en el campo Name
    And muestra el texto "123 Main St" en el campo Address
    And muestra el texto "Springfield" en el campo City
	And muestra el texto "1234567890" en el campo Telephone

  Scenario Outline: Validar campos obligatorios y formato del Telephone
    Given el veterinario está en la página de registro de dueños de mascotas
    When el veterinario ingresa "<First Name>" en el campo First Name
    And el veterinario ingresa "<Last Name>" en el campo Last Name
    And el veterinario ingresa "<Address>" en el campo Address
    And el veterinario ingresa "<City>" en el campo City
    And el veterinario ingresa "<Telephone>" en el campo Telephone
    And el veterinario hace clic en el botón Add Owner
    Then el sistema debería mostrar bajo el campo "<ErrorField>" el mensaje de error "<ErrorMessage>"

    Examples:
      | First Name | Last Name | Address     | City        | Telephone   | ErrorField  | ErrorMessage                        |
      |            | Doe       | 123 Main St | Springfield | 1234567890  | First Name  | no debe estar vacío                 |
      | John       |           | 123 Main St | Springfield | 1234567890  | Last Name   | no debe estar vacío                 |
      | John       | Doe       |             | Springfield | 1234567890  | Address     | no debe estar vacío                 |
      | John       | Doe       | 123 Main St |             | 1234567890  | City        | no debe estar vacío                 |
      | John       | Doe       | 123 Main St | Springfield |             | Telephone   | no debe estar vacío                 |
      | John       | Doe       | 123 Main St | Springfield | 12345       | Telephone   | Telephone must be a 10-digit number |
      | John       | Doe       | 123 Main St | Springfield | abcdefghij  | Telephone   | Telephone must be a 10-digit number |
      
  Scenario: Buscar un dueño de mascota por apellido
    Given el veterinario está en la página de búsqueda de dueños de mascotas
    When el veterinario ingresa "<Last Name>" en el campo Last Name
    And el veterinario hace clic en el botón Find Owner
    Then el sistema debería dirigir a la pantalla de detalles del dueño de mascota
    And muestra el texto "<Name>" en el campo Name
    And muestra el texto "<Address>" en el campo Address
    And muestra el texto "<City>" en el campo City
	And muestra el texto "<Telephone>" en el campo Telephone
	
	Examples:
      | Last Name  | Name              | Address           | City        | Telephone   |
      | Rodriquez  | Eduardo Rodriquez | 2693 Commerce St. | McFarland   | 6085558763  |

  Scenario: Editar ciudad y telefono de dueño de mascota
    Given el veterinario está en la página de búsqueda de dueños de mascotas
    When el veterinario ingresa "<Last Name>" en el campo Last Name
    And el veterinario hace clic en el botón Find Owner
    Then el sistema debería dirigir a la pantalla de detalles del dueño de mascota
    When el veterinario hace clic en el botón Edit Owner
    When el veterinario ingresa "<City>" en el campo City
    And el veterinario ingresa "<Telephone>" en el campo Telephone
    When el veterinario hace clic en el botón Update Owner
    Then el sistema debería dirigir a la pantalla de detalles del dueño de mascota
    And muestra el texto "<Name>" en el campo Name
    And muestra el texto "<Address>" en el campo Address
    And muestra el texto "<City>" en el campo City
	And muestra el texto "<Telephone>" en el campo Telephone
	
	Examples:
      | Last Name  | Name              | Address           | City         | Telephone   |
      | Rodriquez  | Eduardo Rodriquez | 2693 Commerce St. | McFarland2   | 1334267890  |