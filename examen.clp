(deftemplate horario
     12 24 horas
     ( (dia (13 1) (18 0))
       (tarde (12 0) (18 1) (22 0))
       (noche (17 0) (22 1))
     )
)

(deftemplate volumen
     0 10 grados
     ( (bajo (3 1) (8 0))
       (medio (0 0) (5 1) (10 0))
       (alto (6 0) (8 1))
     )
)

(defrule obtiene_hora
   (declare (salience 100))

   =>

   (printout t "Introduce la hora: ")
   (bind ?t (read))
   (assert (valor_hora ?t)))


  (defrule Fuzzifica_hora
     (valor_hora ?t)

       =>

      (bind ?t1 (- ?t 0.01))
      (bind ?t2 (+ ?t 0.01))
      (assert (horario (?t1 0) (?t 1) (?t2 0))))

      (defrule rdia
      (horario dia)
      =>
      (assert(volumen alto))
      )

      (defrule rdia
      (horario tarde)
      =>
      (assert(volumen medio))
      )

      (defrule rdia
      (horario noche)
      =>
      (assert(volumen bajo))
      )

      (defrule Muestra_volumen
       (declare (salience -100))
       ?f <- (volumen ?p)
       =>
       (plot-fuzzy-value t "*" nil nil ?f)
       (printout t "Volumen: " (moment-defuzzify ?f)  crlf))
