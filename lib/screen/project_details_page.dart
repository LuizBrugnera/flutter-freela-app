import 'package:flutter/material.dart';
import 'package:freela_app/models/project_model.dart';
import 'package:intl/intl.dart';

class ProjectDetailsPage extends StatelessWidget {
  final Project project;

  ProjectDetailsPage({required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Projeto'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                project.title,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                project.category,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.grey),

              ),
              SizedBox(height: 16),
              Text(
                'R\$ ${project.minBudget.toStringAsFixed(0)} - R\$ ${project.maxBudget.toStringAsFixed(0)}',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                project.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 16),
              Wrap(
                spacing: 8,
                children: project.skills.map((skill) => Chip(label: Text(skill))).toList(),
              ),
              SizedBox(height: 16),
              _buildInfoRow(Icons.calendar_today, 'Publicado em: ${_formatDate(project.publishedDate)}'),
              SizedBox(height: 8),
              _buildInfoRow(Icons.timer, 'Prazo: ${project.deadline} dias'),
              SizedBox(height: 8),
              _buildInfoRow(Icons.work, project.workType),
              SizedBox(height: 24),
              Text(
                'Sobre o Cliente',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: 8),
              ListTile(
                leading: CircleAvatar(
                  child: Text(project.clientName[0]),
                ),
                title: Text(project.clientName),
                subtitle: Row(
                  children: [
                    Icon(Icons.star, size: 16, color: Colors.amber),
                    SizedBox(width: 4),
                    Text('${project.clientRating} | ${project.clientProjects} projetos'),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Enviar Proposta',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Valor da Proposta (R\$)',
                  prefixIcon: Icon(Icons.attach_money),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Tempo de Entrega (em dias)',
                  prefixIcon: Icon(Icons.timer),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Carta de Apresentação',
                  hintText: 'Descreva por que você é a melhor escolha para este projeto...',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement proposal submission logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Proposta enviada com sucesso!')),
                  );
                },
                child: Text('Enviar Proposta'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        SizedBox(width: 8),
        Text(text, style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }
}