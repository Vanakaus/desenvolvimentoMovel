import { User } from "@prisma/client";
import { prisma } from "../../../../prisma/client";
import { CreateUserDTO } from "../../interface/CreateUserDTO";
import { AppError } from "../../../../errors/AppErrors";

export class ListUserUseCase{
    async execute(): Promise<object[]>{
        // async execute(): void{
            console.log("asdasd");

        const users = await prisma.user.findMany();
        console.log(users);

        if(!users){
            console.log("Sem Usuários cadastrados");
            throw new AppError('Sem Usuários cadastrados');
        }
        
        return users;
    }
}