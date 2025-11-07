class Viaje{
    const property idiomas = #{}    
   
    method implicaEsfuerzo()
    method broncearse() 
    method diasDeViaje()
    method idiomasQueSeHablan() = idiomas
    method viajeInteresante() = idiomas.size() > 1
    method agregarIdioma(idioma){
        idiomas.add(idioma)
    }
    method esRecomendado(unSocio) = self.viajeInteresante() and unSocio.leAtrae(self) and !unSocio.actividadesRealizadas().contains(self)
}
class ViajeDePlaya inherits Viaje{
    const largo
    override method diasDeViaje() = self.largo()/500
    override method implicaEsfuerzo() = self.largo() > 1200
    method largo() = largo
    override method broncearse() = true
}
class Ciudad inherits Viaje{
    var property atracciones

    method cantidadDeAtracciones() = atracciones
    override method viajeInteresante() = super() || self.cantidadDeAtracciones() == 5
    override method diasDeViaje() = self.cantidadDeAtracciones()/2
    override method implicaEsfuerzo() = self.cantidadDeAtracciones().between(5, 8)
    override method broncearse() = false
}
class CiudadTropical inherits Ciudad{
    
    override method diasDeViaje() = super() + 1    
    override method broncearse() = true
}
class SalidaDeTrekking inherits Viaje{
    var kilometros
    var diasDeSol
    method kilometros() = kilometros
    method diasDeSol() = diasDeSol
    override method viajeInteresante() = super() && self.diasDeSol() > 140
    override method diasDeViaje() = self.kilometros()/50
    override method implicaEsfuerzo() = self.kilometros() > 80
    override method broncearse() = self.diasDeSol() > 200 || (self.diasDeSol().between(100, 200) && self.kilometros() > 120)

}
class Gimnasia inherits Viaje{
    override method idiomasQueSeHablan() = #{ "Español" }
    override method diasDeViaje() = 1
    override method implicaEsfuerzo() = true
    override method broncearse() = false
    override method esRecomendado(unSocio) = unSocio.edad().between(20, 30)
}
       
    
class Socio{
    var actividadesRealizadas = []
    var maximoActividades
    var edad
    var idiomas = []
    var tipo 
    method idiomas() = idiomas
    method tipo() = tipo
    method  maximoActividades() = maximoActividades
    method actividadesRealizadas() = actividadesRealizadas
    method adoradorDelSol() = self.actividadesRealizadas().forAll({v => v.broncearse()})
    method actividadesEsforzadas() = self.actividadesRealizadas().filter({v => v.implicaEsfuerzo()})
    method registrarActividad(actividad){
        if(self.actividadesRealizadas().size() < self.maximoActividades()){
            actividadesRealizadas.add(actividad)
        }
    }
    method leAtrae(unaActividad){
        if(self.tipo() == "tranquilo"){
            unaActividad.diasDeViaje() >= 4
        }
        if(self.tipo() == "coherente"){
            if(self.adoradorDelSol()){
                unaActividad.broncearse()
            }
            else{
                unaActividad.implicaEsfuerzo()
            }
        }
        if(self.tipo() == "relajado"){
            self.idiomas().any({i => unaActividad.idiomasQueSeHablan().contains(i)})
        }
    }
}
class TallerLiterario inherits Viaje{
    var libros = []
    method libros() = libros
    override method esRecomendado(unSocio) = unSocio.idiomas() > 1
    override method broncearse() = false
    override method idiomasQueSeHablan() = self.libros().map({l => l.idioma()}.asSet())
    override method diasDeViaje() = self.libros().size() + 1
    override method implicaEsfuerzo() = self.libros().any({l => l.cantidadDePaginas() > 500}) || self.libros().all({l => l.autor() == self.libros().first().autor()})
}
class Libro {
    var idioma
    var cantidadDePaginas
    var autor
    method idioma() = idioma
    method cantidadDePaginas() = cantidadDePaginas
    method autor() = autor
}