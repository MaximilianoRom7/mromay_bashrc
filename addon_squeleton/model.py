from odoo import api, fields, models, _

class MiClase(models.Model):
    #
    # Clase de ejemplo
    #
    # _name: es la propiedad que se usa para crear la tabla
    # se remplaza el '.' por '_' entonces el modelo con
    # nombre 'personas.hijos' crea la tabla 'personas_hijos'
    #
    # ejemplo:
    # _name = 'personas.hijos'
    #
    # los campos crean las columnas en la tabla, cada una con su respectivo tipo
    # todos los tipos que usa odoo son los siguientes
    #
    # variable = fields.Boolean("...")
    # variable = fields.Integer("...")
    # variable = fields.Float("...")
    # variable = fields.Monetary("...")
    # variable = fields.Char("...")
    # variable = fields.Text("...")
    # variable = fields.Html("...")
    # variable = fields.Date("...")
    # variable = fields.Datetime("...")
    # variable = fields.Binary("...")
    # variable = fields.Selection("...")
    # variable = fields.Reference("...")
    # variable = fields.Many2one("...")
    # variable = fields.One2many("...")
    # variable = fields.Many2many("...")
    #
    # ejemplo:
    # nombre = fields.Char("Nombre de la persona")
    # edad = fields.Integer("Edad de la persona")
    pass
