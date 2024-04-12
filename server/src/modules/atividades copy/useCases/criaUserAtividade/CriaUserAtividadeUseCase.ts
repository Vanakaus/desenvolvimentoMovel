import { prisma } from "../../../../prisma/client";
import { CriaUserAtividadeDTO } from "../../interface/CriaUserAtividadeDTO";
import { AppError } from "../../../../errors/AppErrors";
import { userAtividades } from "@prisma/client";

export class CriaUserAtividadeUseCase{
    async execute({id_aluno, id_atividade}: CriaUserAtividadeDTO): Promise<userAtividades>{

        const user = await prisma.user.findFirst({
            where: {
                id: id_aluno
            }
        });

        if(!user){
            throw new AppError('Usuário não encontrado');
        }

        const atividade = await prisma.atividade.findFirst({
            where: {
                id: id_atividade
            }
        });

        if(!atividade){
            throw new AppError('Atividade não encontrada');
        }


        let userAtividade = await prisma.userAtividades.findFirst({
            where: {
                id_aluno: id_aluno,
                id_atividade: id_atividade
            }
        });
        
        if(userAtividade){
            throw new AppError('Atividade já entregue');
        }


        userAtividade = await prisma.userAtividades.create({
            data: {
                id_aluno: id_aluno,
                id_atividade: id_atividade,
            }
        });

        if(!userAtividade){
            throw new AppError('Erro ao entregar atividade');
        }


        console.log("Atividade entregue com sucesso");
        console.log(userAtividade);
        
        return userAtividade;
    }
}