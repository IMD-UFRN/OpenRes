# -*- encoding : utf-8 -*-

class Importer

  def self.import
    File.open("users.csv").read.split("\n").each_with_index do |line, index|
      next if index == 0

      #function = {"admin"=> "Administrador do Sistema", "sector_admin"=> "Adminitração de Setor", "secretary"=>"Secretaria", "basic"=> "Básica"}
      roles ={"Adminitração de Setor"=> "sector_admin", "Secretaria"=> "secretary", "Básica"=> "basic"}
      sectors = {
        "BTI"                                     => 1,
        "Técnigo em TI"                           => 2,
        "BES"                                     => 3,
        "IMD Administrativo"                      => 4,
        "IMD Datacenter e Suporte Técnico"        => 5,
        "IMD Uso Geral"                           => 6,
        "Incubação"                               => 7,
        "Departamento de Informática Educacional" => 8,
        "Psicologia e Serviço Social"             => 9
      }

      name, email, setor, papel, cpf = line.split(";")
      puts "nome: "+ name, "email: "+ email, "setor: " + sectors[setor].to_s, "papel: " + roles[papel], "cpf: "+ cpf.to_s

      Users::UserService.create(role: roles[papel], email: email, name: name, cpf: cpf, sector_id: sectors[setor])

    end

  end
end