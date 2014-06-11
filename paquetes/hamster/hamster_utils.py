#!/usr/bin/env python
# encoding: utf-8
# --------------------------------------------------------------------------
import sys
import datetime

from hamster import client
from hamster.lib import stuff, Fact


class HamsterCli(object):
    
    def __init__(self):
        self.storage = client.Storage()

    @property
    def tarea_actual(self):
        tareas = self.tareas_hoy

        if not tareas:
            return

        tarea = tareas[-1]
        if tarea.end_time:
            return

        return tarea

    @property
    def tarea_actual_txt(self):
        tarea = self.tarea_actual
        if not tarea:
            return u"Sin tarea"

        duracion = stuff.format_duration(tarea.delta)
        if not duracion:
            duracion = u"Acaba de empezar"

        tarea = u"{0} - {1}".format(tarea.activity, duracion)
        return tarea
        
    @property
    def tareas_hoy(self):
        return self.storage.get_todays_facts()

    @property
    def fixes(self):
        tarea = self.tarea_actual
        if not tarea:
            return ""
            
        duracion = stuff.format_duration(tarea.delta).replace(" ", "").replace("min", "m")
        return "fixes {0} @{1}".format(tarea.activity, duracion)

    @property
    def refs(self):
        tarea = self.tarea_actual
        if not tarea:
            return ""
            
        duracion = stuff.format_duration(tarea.delta).replace(" ", "").replace("min", "m")
        return "refs {0} @{1}".format(tarea.activity, duracion)

    @property
    def parar(self):
        self.storage.stop_tracking()


    @property
    def nueva(self):
        self.parar
        
        inicio = datetime.datetime.now()
        desc = sys.argv[2]

        self.storage.add_fact(Fact(desc,
                                   start_time=inicio,
                                   end_time=None))
        return ""

    @property
    def nuevaantigua(self):
        self.parar

        tareas = self.tareas_hoy

        if not tareas:
            return ""

        tarea = tareas[-1]
        inicio = tarea.end_time
        desc = sys.argv[2]

        self.storage.add_fact(Fact(desc,
                                   start_time=inicio,
                                   end_time=None))
        return ""
        

if __name__ == "__main__":
    from hamster.lib import i18n
    i18n.setup_i18n()

    try:
        accion = sys.argv[1]
    except IndexError:
        accion = "tarea_actual_txt"
    else:
        accion = accion.replace("--", "")

    cli = HamsterCli()
    metodo = getattr(cli, accion)
    sys.stdout.write(metodo)
    

