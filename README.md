# Rapture
Rapture is a light weight, small dependency  object application framework.
It meant to provide a highly customizable, multi language application interface.

Key highlights:
- brandable templates and string content.
- Support for multiple languages.
- Reusable strings. There are global strings, and application and view specific strings.
  Each elvel inherits from the last, and has the ability to overide the inherited values.

- Easy templating system in XML, that can be structurally verified using a Schema.
- Reusable UI widgets. The application views are constructed with a common set of Element objects
  that are defined at each level of the application. THere are global elements, application elements 
  and view elements, each inheriting from the last, with the ability to overwrite the inherited values.

- private encapsulation for Object structures.
  The Rapture object structures is a blessed subroutine. i
    - Allows for a very fine control over access to the objecs features and attributes. 
    - Provides private encapsulation for all object attributes.
    - It helps enforce object usage thru the defined method interface
    - provides a central location for object construction, and injection for debugging purposes.
    

