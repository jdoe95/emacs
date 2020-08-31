(setq-default periph-name nil)
(setq-default reg-name nil)
(setq-default reg-type nil)
(setq-default field-name nil)
(setq-default field-mask nil)
(setq-default field-pos nil)

(define-skeleton regfield
  "Inserts register field macros."
  nil
  '(setq periph-name (upcase (skeleton-read "Peripheral name: " periph-name)))
  '(setq reg-name    (upcase (skeleton-read "Register name: " reg-name)))
  '(setq reg-type    (skeleton-read "Register type: "reg-type))
  ("Insert field"
   nil
    '(setq field-name (upcase (skeleton-read "Field name: ")))
    '(setq field-mask (skeleton-read "Field mask: " "1" ))
    '(setq field-pos  (upcase (skeleton-read "Field pos: ")))
    "#define " periph-name "_" reg-name "_" field-name "   "
    "((" reg-type ") (" field-mask " << " field-pos "))" \n)
  )

(setq-default reg-type nil)
(setq-default field-pos nil)
(setq-default val-name nil)
(define-skeleton regval
  "Inserts register value macros."
  nil
  '(setq periph-name (upcase (skeleton-read "Peripheral name: " periph-name)))
  '(setq reg-name    (upcase (skeleton-read "Register name: " reg-name)))
  '(setq reg-type    (skeleton-read "Register type: " reg-type))
  '(setq field-name  (upcase (skeleton-read "Field name: " field-name)))
  '(setq field-pos   (upcase (skeleton-read "Field pos: " field-pos)))
  ("Insert value"
   nil
   '(setq field-val  (skeleton-read "Field value: "))
   '(setq val-name   (upcase (skeleton-read "Field value name: ")))
   "#define " periph-name "_" reg-name "_" field-name "_" val-name "    "
   "((" reg-type ") (" field-val " << " field-pos "))" \n)
  )
  
  
(define-skeleton regstruct
  "Inserts register structs."
  nil
  '(setq periph-name (upcase (skeleton-read "Peripheral name: "
					    periph-name)))
  "#include <stdint.h>" \n
  \n
  "struct __attribute__((aligned, packed)) " (downcase periph-name)
  "_struct" \n
  > "{" > \n
  > _ > \n
  > "};" > \n
  \n
  "extern struct " (downcase periph-name) "_struct " periph-name ";"
  \n
  \n)
