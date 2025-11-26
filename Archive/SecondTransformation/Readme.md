# Second Transformation Files (4 July 2025)

Diese xslts folgen nach dem ersten framework (pre-processing).
Als erstes werden glossen mit mehreren lines zusammengefasst, dann @ns für die textlines vergeben.
Die zählung muss adaptiert werden, dass sie bei jedem <pb> neu anfängt, dass wir linenumbers pro seite haben.
Basierend auf diesen werden dann xml:ids vergeben.
Im 10. xslt wird dann der gesamte text an whitespace tokenisiert.
Im letzten schritt dann für jedes <w> eine xml:id vergeben.
