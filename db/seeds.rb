# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Clean tables
User.delete_all
Country.delete_all
Parameter.delete_all

# Reset postgres auto increments
Country.connection.execute('ALTER SEQUENCE countries_id_seq RESTART WITH 1')
User.connection.execute('ALTER SEQUENCE users_id_seq RESTART WITH 1')
Parameter.connection.execute('ALTER SEQUENCE parameters_id_seq RESTART WITH 1')

# Countries
country_CL = Country.create! name: 'Chile'
country_AR = Country.create! name: 'Argentina'
country_CO = Country.create! name: 'Colombia'
country_PE = Country.create! name: 'Perú'
country_US = Country.create! name: 'Estados Unidos'
country_EC = Country.create! name: 'Ecuador'
country_PY = Country.create! name: 'Paraguay'
country_BR = Country.create! name: 'Brasil'

# Users
# user_1 = User.create! firstname: 'System', lastname: 'Admin', email:'admin@requies.cl', password:'admin123', password_confirmation:'admin123', role: 0, bp: 123456, enabled: true, country: country_CL
# user_2 = User.create! firstname: 'Caio', lastname: 'Bezares', email:'caio@requies.cl', password:'caio123', password_confirmation:'caio123', role: 0, bp: 234567, enabled: true, country: country_CL
# user_3 = User.create! firstname: 'Danilo', lastname: 'Aburto', email:'danilo@requies.cl', password: 'danilo123', password_confirmation:'danilo123', role: 0, bp: 345678, enabled: true, country: country_CL
