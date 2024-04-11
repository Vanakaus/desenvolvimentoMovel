import { prisma } from "../../../../prisma/client";
import { CriaAtividadeDTO } from "../../interface/CriaAtividadeDTO";
import { AppError } from "../../../../errors/AppErrors";
import { Atividade } from "@prisma/client";

export class CriaAtividadeUseCase{
    async execute({titulo, descricao}: CriaAtividadeDTO): Promise<Atividade>{
        

        const atividade = await prisma.atividade.create({
            data: {
                titulo,
                descricao
            }
        });

        if(!atividade){
            console.log("Erro ao criar atividade");
            throw new AppError('Erro ao criar atividade');
        }


        console.log("Atividade criada com sucesso");
        console.log(atividade);
        
        return atividade;
    }
}