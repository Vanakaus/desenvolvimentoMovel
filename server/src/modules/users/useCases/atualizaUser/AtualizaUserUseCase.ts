import { prisma } from "../../../../prisma/client";
import { AppError } from "../../../../errors/AppErrors";

export class AtualizaUserUseCase{
    async execute(id: number, email: string, senha: string): Promise<Object>{

        const user = await prisma.user.findUnique({
            where: {
                id: id
            }
        });


        if(!user){
            console.log("Usuário não encontrado");
            throw new AppError('Usuário não encontrado', 404);
        }

        const userUpdated = await prisma.user.update({
            where: {
                id: id
            },
            data: {
                email: email,
                senha: senha
            }
        });

        console.log("Usuário atualizado com sucesso");
        console.log(userUpdated);
        
        return user;
    }
}