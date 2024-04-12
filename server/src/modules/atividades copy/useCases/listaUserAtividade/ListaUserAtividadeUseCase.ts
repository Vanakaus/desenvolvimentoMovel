import { prisma } from "../../../../prisma/client";
import { AppError } from "../../../../errors/AppErrors";

export class ListaUserAtividadeUseCase{
    async execute(id_aluno: number): Promise<object[]>{

        const atividades = await prisma.userAtividades.findMany({
            where: {
                id_aluno: id_aluno
            },
            include: {
                atividade: true
            }
        });


        if(!atividades){
            throw new AppError('Sem Atividades entregues');
        }

        console.log("Lista de Atividades:");
        console.log(atividades);
        
        return atividades;
    }
}

export class ListaAtividadesUseCase{
    async execute(id_atividade: number): Promise<object[]>{

        const atividades = await prisma.userAtividades.findMany({
            where: {
                id_atividade: id_atividade
            },
            select: {
                id: true,
                id_aluno: true,
                id_atividade: true,
                dataEntrega: true,
                nota: true,
                autor: {
                    select: {
                        name: true,
                        email: true,
                    }
                }
            }
        });


        if(!atividades){
            throw new AppError('Atividade não encontrada');
        }

        console.log("Lista de Atividades entregues:");
        console.log(atividades);
        
        return atividades;
    }
}